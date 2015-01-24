class UsersController < ApplicationController
  
  load_and_authorize_resource
  
  skip_filter :download_sample
  before_action :set_user, only: [:show]
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :can_edit_users?, only: [:index, :edit, :update, :destroy]
  before_action :classes_all
  before_action :points_all
  before_action :teachers_all
  before_action :terms_all
  respond_to :html, :js
  

  # GET /users?type=[1,2,3,4]&description=['']&class_id=[id]
  def index
	  session[:return_to] ||= request.referer
  	if params[:type] == '3'
  		  @users = User.where('type = ? AND class_id = ? AND school_id = ?', params[:type], params[:class_id], current_user.school_id).order('username')
    else
  		  @users = User.where('type = ? AND school_id = ?', params[:type], current_user.school_id).order('username')
          
    end
    
    if current_user.type == 1 || current_user.type == 2
       @user =  User.new
    end
 
  end

  # GET /users/1
  def show
	
	#is current user is a guardian dont let him access any users other than his wards
	if current_user.type == 4 && current_user.id.to_s != params[:id]
		@guardian = Guardianship.select('user_id').where('guardian_id = ? AND user_id = ?', current_user.id, params[:id])
		if @guardian.length == 0
			redirect_to root_path, notice: "Access Denied"
		end
	end
	
	#for some reason 'users.type' wasnt working hence the alias was added
	@user = User.joins(:school).where('school_id = ? AND users.id = ?', current_user.school_id, params[:id]).select('users.id, username, first_name, last_name, email, type AS usr_type, enrollment_id, class_id, schools.name, address, phone_no').first
	
	if @user.usr_type == 3
	
		@grade = ClassSection.where(:id => @user.class_id)
		@user_grade =  @grade.first.description
        @all_terms = Term.select(:id, :name, :term_from, :term_to).where(:school_id => @current_user.school_id)
		
		@current_term = Term.select('id, term_from, term_to').where('term_from <= ? AND term_to > ? AND school_id = ?', Time.now, Time.now, current_user.school_id).order('term_from desc').first
		
        if @current_term.nil?
            @total_points = 0
        else
            @student_points_desc = Point.select("student_points.id, description, student_points.assigned_points as assigned_point, credit").joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).order("student_points.created_at")
            
            @total_positive_points = Point.joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).where(:credit => true).sum('value')
            @total_negative_points = Point.joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).where(:credit => false).sum('value')
            
            @total_points = @total_positive_points - @total_negative_points
		end
        
	elsif @user.usr_type == 2
	
		@teacher_class = TeacherClassRelationship.select('class_section_id, teacher_role_id, teacher_class_relationships.id, user_id').joins(:class_section).where('user_id = ?   AND school_id = ?', @user.id, current_user.school_id)
		
	end
    if params[:search]
        @search_user = User.select('id, type, enrollment_id, username, first_name, last_name').where('enrollment_id = ? AND school_id = ?', params[:search], current_user.school_id).order('username').first
        
        respond_to do |format|
            format.html { redirect_to @user, notice: 'User found.' }
            format.js {}
        end
	end
  end
  
  def points_for_term
      @term = Term.select('id, term_from, term_to').where('id = ? AND school_id = ?', params[:term_id], current_user.school_id).order('term_from desc').first
      
      if @current_term.nil?
          @total_points = 0
          else
          
          @student_points_desc = Point.select("student_points.id, description, student_points.assigned_points as assigned_point, credit").joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @term.term_from, @term.term_to).order("student_points.created_at")
          
          @total_positive_points = Point.joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).where(:credit => true).sum('value')
          @total_negative_points = Point.joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).where(:credit => false).sum('value')
          
          @total_points = @total_positive_points - @total_negative_points
      end
  end
  
  def add_guardianship
      Guardianship.create!(:user_id => params[:user_id], :guardian_id => params[:guardian_id])
      @user = User.joins(:school).where('school_id = ? AND users.id = ?', current_user.school_id, params[:user_id]).select('users.id, username, first_name, last_name, email, type, enrollment_id, class_id, schools.name, address, phone_no').first
      respond_to do |format|
          format.html { redirect_to @user, notice: 'Guardianship created.' }
          format.js {}
      end
  end
  
  def destroy_guardianship
      @guardianship = Guardianship.where('user_id = ? AND guardian_id = ?', params[:user_id], params[:guardian_id]).delete_all
      respond_to do |format|
          format.html { redirect_to @user, notice: 'Guardianship removed.' }
          format.js {}
      end
  end


  # GET /users/new
  def new
	@user = User.new
    @user.guardianships.build
  end

  # GET /users/1/edit
  def edit
	@user = User.where('school_id = ?', current_user.school_id).find(params[:id])
  end

  # POST /users
  def create
    #Auto creates guardianship (nested models)
    @user = User.new(user_params)
    @user.school_id = current_user.school_id
    
    
    if @user.save
        
        if @user.type == 4
            #Auto save saves the guardianship upside down so the next two lines ensure the correct column values are exchanged and put into the right columns
            @user_id = params['user']['guardianships_attributes']['0']['user_id'];
            @new_guardian = Guardianship.select('id, user_id, guardian_id').where(:user_id => @user.id).last
            Guardianship.where(:id => @new_guardian.id).update_all(:user_id => @user_id, :guardian_id => @new_guardian.user_id)
        end
        
        UserMailer.welcome_email(@user).deliver
        
	    if @user.type == 3
            @setting = AlertSetting.select('default_points').where('school_id = ?', current_user.school_id).first
            StudentPoint.create!(:user_id => @user.id, :point_id => 1, :assigned_points => @setting.default_points)
	    end
      
      respond_to do |format|
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.js {}
      end
	  
      #redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
      #@user = User.find(params[:id])
    if @user.update(user_params)
      respond_to do |format|
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.js {}
      end
    else
      render action: 'edit'
    end
  end

  # DELETE /users/1
  def destroy
	  session[:return_to] ||= request.referer
      User.find(params[:id]).destroy
      
      respond_to do |format|
          format.html { redirect_to session.delete(:return_to), notice: 'User was successfully destroyed.' }
          format.js {}
      end
  end
  
  def classes_all
	@class_options = ClassSection.where('school_id = ?', current_user.school_id).map{|class_section| [class_section.description, class_section.id]}
  end
  
  
  
  def import
	session[:return_to] ||= request.referer
	if !params[:file]
    	redirect_to session.delete(:return_to), notice: "No file selected."
    else
		@result = User.import_from_file(params[:file], current_user.school_id, params[:type], params[:class_id])
        if @result
            redirect_to session.delete(:return_to), notice: "Users imported."
        else
            redirect_to session.delete(:return_to), notice: "Users could not be imported. Please check the input file data. If the user is a student, Enrollment id should be present. If user is not a Student Email id should be present and must be unique."
        end
	end
  end
  
  def download_sample
    file_path = "#{Rails.root}/public/users.xlsx"
    send_file file_path, :filename => 'users.xlsx'
  end
  
  def points_all
  	@point_options = Point.where('id != 1 and id != 2 and school_id = ?', current_user.school_id)
  end
  
  def teachers_all
  	@teacher_classes = ClassSection.where('school_id = ?', current_user.school_id).map{|class_section| [class_section.description, class_section.id]}
	@teacher_roles = TeacherRole.where('id = 1 OR id = 2').select('id, description').map{|teacher_role| [teacher_role.description, teacher_role.id]}
  end 
  
  def terms_all
	@term_count = Term.where('school_id = ?', current_user.school_id).count
  end
  
  
  def get_term
      @term = Term.select('term_to, term_from').where('id = ?', params[:term_id]).first
      @student_points_desc = Point.select("student_points.id, description, student_points.assigned_points as assigned_point, credit").joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', params[:id], @term.term_from, @term.term_to).order("student_points.created_at")
      
      @total_positive_points = Point.joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', params[:id], @term.term_from, @term.term_to).where(:credit => true).sum('value')
      @total_negative_points = Point.joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', params[:id], @term.term_from, @term.term_to).where(:credit => false).sum('value')
      
      @total_points = @total_positive_points - @total_negative_points
      
      respond_to do |format|
          format.html
          format.js
          
          format.json {render :json => @student_points_desc}
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.joins(:school).where('school_id = ? AND users.id = ?', current_user.school_id, params[:id]).select('users.id, username, first_name, last_name, email, type, enrollment_id, class_id, schools.name, address, phone_no').first
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
        params.require(:user).permit(:username, :school_id, :email, :first_name, :last_name, :password, :password_confirmation, :type, :enrollment_id, :class_id, :password_reset_token, :password_reset_sent_at, guardianships_attributes: [:id, :user_id, :guardian_id])
    end
	
	# Only allow signed in user update/edit profiles
	def signed_in_user
		unless sign_in?
			store_location
			redirect_to root_path, notice: "Please sign in."  
		end
	end
	
	# Only admins are allowed to change a users profile
	def can_edit_users?
		unless current_user.type == 1 or current_user.type == 2 or current_user.id == @user.id
			redirect_to root_path
		end
	end

end

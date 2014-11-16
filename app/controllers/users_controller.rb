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
  

  # GET /users?type=[1,2,3,4]&description=['']&class_id=[id]
  def index
	  session[:return_to] ||= request.referer
  	if params[:type] == '3'
  		  @users = User.where('type = ? AND class_id = ? AND school_id = ?', params[:type], params[:class_id], current_user.school_id).order('username')
	  elsif params[:search]
        @user = User.select('id').where('enrollment_id = ? AND school_id = ?', params[:search], current_user.school_id).order('username').first
		    Guardianship.create!(:guardian_id => params[:guardian_id], :user_id => @user.id)
    		redirect_to session.delete(:return_to)
  	else
  		  @users = User.where('type = ? AND school_id = ?', params[:type], current_user.school_id).order('username')
  	end
  end
  
  def search
	@search = User.search do
		fulltext params[:search]
	end
	@users_search = @search.results
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
		
		@current_term = Term.select('id, term_from, term_to').where('term_from <= ? AND school_id = ?', Time.now, current_user.school_id).order('term_from desc').first
		
		@student_points_desc = Point.select("student_points.id, description, student_points.assigned_points as assigned_point, credit").joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).order("student_points.created_at")
		
		@total_positive_points = Point.joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).where(:credit => true).sum('value')
		@total_negative_points = Point.joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).where(:credit => false).sum('value')
		
		@total_points = @total_positive_points - @total_negative_points
		
	elsif @user.usr_type == 2
	
		@teacher_class = TeacherClassRelationship.select('class_section_id, teacher_role_id, teacher_class_relationships.id, user_id').joins(:class_section).where('user_id = ?   AND school_id = ?', @user.id, current_user.school_id)
		
	end
	
  end

  # GET /users/new
  def new
	@user = User.new
  end

  # GET /users/1/edit
  def edit
	@user = User.where('school_id = ?', current_user.school_id).find(params[:id])
  end

  # POST /users
  def create
    ward_id = User.select('id').where(:id => params["user"]["ward"])
    @user = User.new(user_params)
	  @user.school_id = current_user.school_id

    if @user.save
		
	  UserMailer.welcome_email(@user).deliver
	  if @user.type == 3
		@setting = AlertSetting.select('default_points').where('school_id = ?', current_user.school_id).first
		StudentPoint.create!(:user_id => @user.id, :point_id => 1, :assigned_points => @setting.default_points)
	  end
	  
	  if @user.type == 4 
		Guardianship.create!(:guardian_id => @user.id, :user_id => ward_id)
	  end
	  
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
      #@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /users/1
  def destroy
	  session[:return_to] ||= request.referer
    User.find(params[:id]).destroy
    redirect_to session.delete(:return_to), notice: 'User was successfully destroyed.'
  end
  
  def classes_all
	@class_options = ClassSection.where('school_id = ?', current_user.school_id).map{|class_section| [class_section.description, class_section.id]}
  end
  
  
  
  def import
	session[:return_to] ||= request.referer
	if !params[:file]
    	redirect_to session.delete(:return_to), notice: "No file selected."
    else
		@result = import_from_file(params[:file], current_user.school_id, params[:type], params[:class_id])
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
  	@point_options = Point.where('id != 1 and id != 2 and school_id = ?', current_user.school_id).map{|point| [point.description, point.credit, point.value, point.card_offense_id, point.id]	}
  end 
  
  def teachers_all
  	@teacher_classes = ClassSection.where('school_id = ?', current_user.school_id).map{|class_section| [class_section.description, class_section.id]}
	@teacher_roles = TeacherRole.all.map{|teacher_role| [teacher_role.description, teacher_role.id]}
  end 
  
  def terms_all
	@term_count = Term.where('school_id = ?', current_user.school_id).count
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.joins(:school).where('school_id = ? AND users.id = ?', current_user.school_id, params[:id]).select('users.id, username, first_name, last_name, email, type, enrollment_id, class_id, schools.name, address, phone_no').first
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :school_id, :email, :first_name, :last_name, :password, :password_confirmation, :type, :enrollment_id, :class_id, :password_reset_token, :password_reset_sent_at)
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

  def import_from_file(file, school_id, user_type, class_id)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
            row = Hash[[header, spreadsheet.row(i)].transpose]
            user = User.find_by_id(row["id"]) || new
            #(:username, :email, :first_name, :last_name, :enrollment_id
            user.attributes = row.to_hash
            user.school_id = school_id
            user.type = user_type
            user.password = SecureRandom.hex(13)
            user.password_confirmation = user.password

            if user_type == '3'
              user.class_id = class_id
            end
            
            if user_type == '4'
              user.enrollment_id = 0
              ward_enrollment_ids = row["enrollment_id"].split(",")
            end
            
            unless user.save
                return false
            end
            
            if (@user.email?)
                UserMailer.welcome_email(@user).deliver
            end
            
            if user_type == '4'
              ward_enrollment_ids = Array.new
              ward_enrollment_ids.each do |enrollment_id|
                user_id = User.select('id').where(:enrollment_id => enrollment_id).first
                Guardianship.create!(:guardian_id => user.id, :user_id => user_id.id)
              end
            end
      end
      return true
    end
    
    def open_spreadsheet(file)
      case File.extname(file.original_filename)
              when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
              when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
              when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
              else raise "Unknown file type: #{file.original_filename}"
      end
    end
    
    def to_csv(options = {})
      CSV.generate(options) do |csv|
            csv << column_names
            all.each do |user|
              csv << user.attributes.values_at(*column_names)
            end
      end
    end
	
end

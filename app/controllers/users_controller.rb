class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :can_edit_users?, only: [:index, :edit, :update, :destroy]
  before_action :classes_all

  # GET /users?type=[1,2,3,4]&description=['']&class_id=[id]
  def index
  	if params[:type] == '3'
  		@users = User.where("type = ? AND class_id = ?", params[:type], params[:class_id])
  	else
  		@users = User.where("type = ?", params[:type])
		
  	end
  	
  end
  
 # def search
  #	@search = User.search do
	#	fulltext params[:query]
	#end
  #end

  # GET /users/1
  def show
	@user = User.find(params[:id])
	
	if @user.type == 3
	
		@grade = ClassSection.where(:id => @user.class_id)
		@user_grade =  @grade.first.description
		
		@current_term = Term.select('id, term_from, term_to').where('term_from <= ?', Time.now).order('term_from desc').first
		
		@student_points_desc = Point.select("student_points.id, description, value, credit").joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).order("student_points.created_at")
		
		@total_positive_points = Point.joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).where(:credit => true).sum('value')
		@total_negative_points = Point.joins(:student_points).where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @user.id, @current_term.term_from, @current_term.term_to).where(:credit => false).sum('value')
		
		@total_points = @total_positive_points - @total_negative_points
		
	elsif @user.type == 2
	
		@teacher_class = TeacherClassRelationship.select('class_section_id, teacher_role_id, teacher_class_relationships.id, user_id').joins(:class_section).where('user_id = ?', @user.id)
		
	end
  end

  # GET /users/new
  def new
	@user = User.new
  end

  # GET /users/1/edit
  def edit
	@user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
	@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /users/1
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end
  
  def classes_all
	@class_options = ClassSection.all.map{|class_section| [class_section.description, class_section.id]}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation, :type, :enrollment_id, :class_id)
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
		unless current_user.type == 1 or current_user.type == 2
			redirect_to root_path
		end
	end 

	
end

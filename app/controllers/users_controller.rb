class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :admin?, only: [:index, :edit, :update, :destroy]
  before_action :classes_all

  # GET /users?type=[1,2,3,4]&description=['']&class_id=[id]
  def index
	@users = User.where("type = ? AND (class_id = ? OR class_id IS NULL)", params[:type], params[:class_id])
    #@users = User.joins(:user_types).where("user_types.description = #{params[:type]}")
  end

  # GET /users/1
  def show
	@user = User.find(params[:id])
	@grade = ClassSection.where(:id => @user.class_id)
	@user_grade =  @grade.first.description
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
	def admin?
		unless current_user.type == 1 
			redirect_to root_path
		end
	end 
	
end

class TeacherRolesController < ApplicationController
  load_and_authorize_resource
  before_action :set_teacher_role, only: [:show, :edit, :update, :destroy]

  # GET /teacher_roles
  def index
    @teacher_roles = TeacherRole.all
  end

  # GET /teacher_roles/1
  def show
  end

  # GET /teacher_roles/new
  def new
    @teacher_role = TeacherRole.new
  end

  # GET /teacher_roles/1/edit
  def edit
  end

  # POST /teacher_roles
  def create
    @teacher_role = TeacherRole.new(teacher_role_params)

    if @teacher_role.save
      redirect_to @teacher_role, notice: 'Teacher role was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /teacher_roles/1
  def update
    if @teacher_role.update(teacher_role_params)
      redirect_to @teacher_role, notice: 'Teacher role was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /teacher_roles/1
  def destroy
    @teacher_role.destroy
    redirect_to teacher_roles_url, notice: 'Teacher role was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher_role
      @teacher_role = TeacherRole.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def teacher_role_params
      params.require(:teacher_role).permit(:description)
    end
end

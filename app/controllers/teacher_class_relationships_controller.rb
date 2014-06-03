class TeacherClassRelationshipsController < ApplicationController
  before_action :teachers_all
	
  # GET /teacher_class_relationship/new
  def new
    @teacher_class_relationship = TeacherClassRelationship.new
  end

  # POST /teacher_class_relationship
  def create
    @teacher_class_relationship = TeacherClassRelationship.new(teacher_class_params)

    if @teacher_class_relationship.save
      redirect_to user_path(:id => @teacher_class_relationship.user_id), notice: 'Class relation was successfully saved for the teacher.'
    else
      render action: 'new'
    end
  end
  
  # DELETE /teacher_class_relationship/1
  def destroy
    @a = TeacherClassRelationship.find(params[:id]).destroy
    redirect_to user_path(:id => @a.user_id), notice: 'User was successfully destroyed.'
  end
  
  def teachers_all
  	@teacher_classes = ClassSection.where('school_id = ?', current_user.school_id).map{|class_section| [class_section.description, class_section.id]}
	@teacher_roles = TeacherRole.all.map{|teacher_role| [teacher_role.description, teacher_role.id]}
  end 
  
  private

    # Only allow a trusted parameter "white list" through.
    def teacher_class_params
      params.require(:teacher_class_relationship).permit(:user_id, :class_section_id, :teacher_role_id)
    end

end

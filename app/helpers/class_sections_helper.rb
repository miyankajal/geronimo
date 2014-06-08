module ClassSectionsHelper
	def teacher_classes_and_roles(teacher_id, class_id)
		@teacher_role = TeacherClassRelationship.select('teacher_role_id').where('user_id = ? AND class_section_id = ?', teacher_id, class_id).first
		if @teacher_role.nil?
			return 0
		else
			return @teacher_role.teacher_role_id
		end
	end
end

module UsersHelper
	
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end
  
  def get_teacher_class(id)
	@teacher_class = ClassSection.select('description').where('id = ?', id).first
	return @teacher_class.description
  end
  
  def get_teacher_role(id)
	@teacher_role = TeacherRole.select('description').where('id = ?', id).first
	return @teacher_role.description
  end
  
  def get_points_created_at(id)
  	@created_at = StudentPoint.select('created_at').where('id = ?', id).first
  end
  
  def class_teacher?(teacher_id, class_id)
	TeacherClassRelationship.exists?(:user_id => teacher_id, :class_section_id => class_id)
  end
  
end

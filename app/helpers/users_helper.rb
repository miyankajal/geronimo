module UsersHelper
	
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	if user.type = 3
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=wavatar"
	else 
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
	end
    image_tag(gravatar_url, size: "120x120", alt: user.username, class: "avatar")
  end
  
  def get_teacher_class(id)
	@teacher_class = ClassSection.select('description').where('id = ? AND school_id = ?', id, current_user.school_id).first
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
  
  def add_guardian_student_relationship(user_id, guardian_id)
	Guardianship.create!(:user_id => user_id, :guardian_id => guardian_id)
  end
  
  def get_wards(id)
	@wards = User.joins(:guardianships).where('guardian_id = ?', id)
  end
  
  def get_guardians(id)
	@guardians = Guardianship.select('guardian_id').where('user_id = ?', id)
	
	@guardianArr = Array.new
	@guardians.each do |a|
		@guardianArr.push(User.where('id = ?', a.guardian_id))
	end
	return @guardianArr
  end
  
  def get_user_type(id)
	@user = User.select('type').where('id = ?', id).first
  end
  
  def destroy_guardian_student_relationship(user_id, guardian_id)
	@guardianship = Guardianship.select('id').where(['user_id = ? AND guardian_id = ?', user_id, guardian_id]).first
	#Guardianship.destroy(@guardianship)
  end
  
end

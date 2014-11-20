module IdeasHelper

	def gravatar_for_idea(email, type)
        gravatar_id = Digest::MD5::hexdigest(email)
        if email.nil?
            gravatar_url = "student.jpeg"
        else
        
            if type = 3
                gravatar_url = "http://www.gravatar.com/avatar.php?gravatar_id=#{gravatar_id}?d=wavatar"
            else 
                gravatar_url = "admin.png"
            end
        end
        image_tag(gravatar_url, size: "60x60", class: "avatar")
	end
	
end

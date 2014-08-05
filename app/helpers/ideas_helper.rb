module IdeasHelper

	def gravatar_for_idea(email, type)
		gravatar_id = Digest::MD5::hexdigest(email)
		if type = 3
			gravatar_url = "http://www.gravatar.com/avatar.php?gravatar_id=#{gravatar_id}?d=wavatar"
		else 
			gravatar_url = "http://www.gravatar.com/avatar.php?gravatar_id=#{gravatar_id}"
		end
		image_tag(gravatar_url, size: "60x60", class: "avatar")
	end
	
end

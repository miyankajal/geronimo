module SessionsHelper
	
	def sign_in(user, remember_me)
		remember_token = User.new_remember_token
		if remember_me
			cookies.permanent[:remember_token] = remember_token
		else
			cookies[:remember_token] = remember_token
		end
		user.update_attribute(:remember_token, User.hash(remember_token))
		
		self.current_user = user
		
		set_product_points
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		remember_token = User.hash(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end
	
	def current_user?(user)
		user == current_user
	end
	
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end
	
	def store_location
		session[:return_to] = request.url if request.get?
	end
	
	def set_product_points
		#1 = Student Points
		session[:product] = 1
		#redirect_to user_path(current_user)
	end
	
	def set_product_ideas
		#2 = Ideas Tank
		session[:product] = 2
		#redirect_to user_path(current_user)
	end
	
	def sign_in?
		!current_user.nil?
	end
	
	def sign_out
		if current_user.nil?
			current_user.update_attribute(:remember_token, User.hash(User.new_remember_token))
		end
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	
end

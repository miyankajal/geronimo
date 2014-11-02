class SessionsController < ApplicationController
	
	def new
	end

	def create
		user = User.select(:id, :first_name, :last_name, :username, :email, :type, :enrollment_id, :class_id, :password_digest).where('email = ? OR username = ?', params[:session][:email].downcase, params[:session][:email].downcase).first
		if user && user.authenticate(params[:session][:password])
			sign_in user, params[:remember_me]
			redirect_back_or user
		else
			flash[:notice]  = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

end

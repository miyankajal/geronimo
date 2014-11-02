class SessionsController < ApplicationController
	prepend_before_filter :verify_user, only: [:destroy]
	
	def new
	end

	def create
	  user = User.select(:id, :first_name, :last_name, :username, :email, :type, :enrollment_id, :class_id, :password_digest).where('LOWER(email) = ? OR LOWER(username) = ?', params[:session][:email].downcase, params[:session][:email].downcase).first
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

  private
    ## This method intercepts SessionsController#destroy action 
    ## If a signed in user tries to sign out, it allows the user to sign out 
    ## If a signed out user tries to sign out again, it redirects them to sign in page
    def verify_user
      ## redirect to appropriate path
      redirect_to root_url, notice: 'You have already signed out. Please sign in again.' unless !current_user.nil?
    end
end

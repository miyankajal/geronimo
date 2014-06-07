class UserMailer < ActionMailer::Base
  default from: 'team.geronimo.inc@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://geronimo.com/login'
    mail(to: @user.email, subject: 'Welcome to Geronimo!!!')
  end
  
  def min_points_email(user)
    @user = user
	@student = student
    @url  = 'http://geronimo.com/login'
    mail(to: @user.email, subject: 'Minimum points')
  end
  
  def repetition_email(user)
    @user = user
    @url  = 'http://geronimo.com/login'
    mail(to: @user.email, subject: 'Repetition')
  end
  
  def session_start_email(user)
    @user = user
    @url  = 'http://geronimo.com/login'
    mail(to: @user.email, subject: 'Session start')
  end
  
  def too_many_email(user)
    @user = user
    @url  = 'http://geronimo.com/login'
    mail(to: @user.email, subject: 'Too many issues')
  end
  
  def password_reset_email(user)
	@user = user
	@url  = 'http://geronimo.com/login'
	mail(to: @user.email, subject: 'Password Reset')
  end
  
end

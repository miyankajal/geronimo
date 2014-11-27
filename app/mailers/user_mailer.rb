class UserMailer < ActionMailer::Base
  default from: 'myteamgeronimo@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://mygeronimo.com'
    mail(to: @user.email, subject: 'Welcome to Geronimo!!!')
  end
  
  def appreciation_email(user, student, point)
      @user = user
      @student = student
      @url  = 'http://mygeronimo.com'
      @point = point
      mail(to: @user.email, subject: 'Student Appreciation Email')
  end
  
  def min_points_email(user, student)
    @user = user
	@student = student
    @url  = 'http://mygeronimo.com'
    mail(to: @user.email, subject: 'For Immediate Attention of the Guardian')
  end
  
  def too_many_email(user, student)
    @user = user
    @student = student
    @url  = 'http://mygeronimo.com'
    mail(to: @user.email, subject: 'For Immediate Attention of the Guardian')
  end
  
  def session_start_email(user)
    @user = user
    @url  = 'http://mygeronimo.com'
    mail(to: @user.email, subject: 'Session start')
  end
  
  def repetition_email(user, student, point)
    @user = user
    @student = student
    @url  = 'http://mygeronimo.com'
	@point = point
    mail(to: @user.email, subject: 'For Immediate Attention of the Guardian')
  end
  
  def password_reset_email(user)
	@user = user
	@url  = 'http://mygeronimo.com'
	mail(to: @user.email, subject: 'Password Reset')
  end
  
  def pink_card_email(user, student, point)
    @user = user
    @student = student
    @url  = 'http://mygeronimo.com'
	@point = point
    mail(to: @user.email, subject: 'For Immediate Attention of the Guardian')
  end
  
  def yellow_card_email(user, student, point)
    @user = user
    @student = student
    @url  = 'http://mygeronimo.com'
	@point = point
    mail(to: @user.email, subject: 'For Immediate Attention of the Guardian')
  end
  
  def red_card_email(user, student, point)
    @user = user
    @student = student
    @url  = 'http://mygeronimo.com'
	@point = point
    mail(to: @user.email, subject: 'For Immediate Attention of the Guardian')
  end
  
  def new_idea_email(user)
    @user = user
    @url  = 'http://mygeronimo.com'
    mail(to: @user.email, subject: 'New Idea on Geronimo!!!')
  end
  
  def report_idea_email(user)
    @user = user
    @url  = 'http://mygeronimo.com'
    mail(to: @user.email, subject: 'Flagged Idea on Geronimo!!!')
  end
  
end

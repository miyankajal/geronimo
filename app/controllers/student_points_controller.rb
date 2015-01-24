class StudentPointsController < ApplicationController
  load_and_authorize_resource
  before_action :points_all
  respond_to :html, :js
  
  # GET /student_points/new
  def new
    @student_point = StudentPoint.new
    
    @point_options = @point_options = Point.joins('INNER JOIN card_offense_types ON card_offense_types.id = points.card_offense_id').select('points.id, points.description, points.value, card_offense_types.description AS card_offense, points.credit, points.card_offense_id').where('points.id != 1 and points.id != 2 and school_id = ?', current_user.school_id)
  end

  # POST /student_points
  def create
	@student_point = StudentPoint.new(student_point_params)
	
    @current_term = Term.select('id, term_from, term_to').where('term_from <= ? AND term_to > ? AND school_id = ?', Time.now, Time.now, current_user.school_id).order('term_from DESC').first
    if @current_term.nil?
        redirect_to user_path(:id => @student_point.user_id), notice: 'Create the Term first.'
    end
    
	if @student_point.assigned_points < 0
		@student_point.is_credit = false
	else	
		@student_point.is_credit = true
	end
	
	#gets send_auto_email, min_points_required, min_points_for_penalty, max_warnings_before_email_alert, repetition_of_mistake_before_email
	@alert_settings = AlertSetting.where('school_id = ?', current_user.school_id).first
    @user = User.where('id = ? AND school_id = ?', @student_point.user_id, current_user.school_id).first
    @guardians = Guardianship.joins(:user).select('guardian_id').where('user_id = ?', @user.id)
    
    #calculate total points
    
    if !@student_point.is_credit
    
        @total_points = StudentPoint.where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @student_point.user_id, @current_term.term_from, @current_term.term_to).sum('assigned_points')
        
        
        @teachers = TeacherClassRelationship.joins('INNER JOIN users ON teacher_class_relationships.class_section_id = users.class_id').select('user_id').where('class_id = ?',  @user.class_id)

        #if Pink card OR Yellow card OR Red card
        if @student_point.card_offense_id == 3 || @student_point.card_offense_id == 4 || @student_point.card_offense_id == 2
            @point = Point.where('id = ?', @student_point.point_id).first
                
            if @alert_settings.send_auto_email
                @guardians.each do |guardian|
                    @email = User.where('id = ?', guardian.guardian_id).first
                    if @student_point.card_offense_id == 3
                        UserMailer.pink_card_email(@email, @user, @point).deliver
                    elsif @student_point.card_offense_id == 4
                        UserMailer.yellow_card_email(@email, @user, @point).deliver
                    elsif @student_point.card_offense_id == 2
                        UserMailer.red_card_email(@email, @user, @point).deliver
                    end
                end
            end
            
            @teachers.each do |teacher|
                @email = User.where('id = ?', teacher.user_id).first
                if @student_point.card_offense_id == 3
                    UserMailer.pink_card_email(@email, @user, @point).deliver
                elsif @student_point.card_offense_id == 4
                    UserMailer.yellow_card_email(@email, @user, @point).deliver
                elsif @student_point.card_offense_id == 2
                    UserMailer.red_card_email(@email, @user, @point).deliver
                end
            end
        end
        
        # Send Alert for min points required
        if @total_points <= @alert_settings.min_points_required
            
            if @alert_settings.send_auto_email
                @guardians.each do |guardian|
                    @email = User.where('id = ?', guardian.guardian_id).first
                    UserMailer.min_points_email(@email, @user).deliver
                end
            end
            
            @teachers.each do |teacher|
                @email = User.where('id = ?', teacher.user_id).first
                UserMailer.min_points_email(@email, @user).deliver
            end
        end
            
        unless @student_point.assigned_points > 0
            @number_of_repetitions = StudentPoint.where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ? and point_id = ?', @student_point.user_id, @current_term.term_from, @current_term.term_to, @student_point.point_id).where('assigned_points < 0').count
            if @number_of_repetitions > @alert_settings.repetition_of_mistake_before_email
                
                @point = Point.where('id = ?', @student_point.point_id).first
                
                if @alert_settings.send_auto_email
                    @guardians.each do |guardian|
                        @email = User.where('id = ?', guardian.guardian_id).first
                        UserMailer.repetition_email(@email, @user, @point).deliver
                    end
                end
                
                @teachers.each do |teacher|
                    @email = User.where('id = ?', teacher.user_id).first
                    UserMailer.repetition_email(@email, @user, @point).deliver
                end
            end
            
            if @student_point.assigned_points >= @alert_settings.min_points_for_penalty
                #find the number of serious felanies committed
                @number_of_serious_offences = StudentPoint.where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ? and assigned_points <= ?', @student_point.user_id, @current_term.term_from, @current_term.term_to, @alert_settings.min_points_for_penalty).where('assigned_points < 0').count
                if @number_of_serious_offences > @alert_settings.max_warnings_before_email_alert
                    
                    if @alert_settings.send_auto_email
                        @guardians.each do |guardian|
                            @email = User.where('id = ?', guardian.guardian_id).first
                            UserMailer.too_many_email(@email, @user).deliver
                        end
                    end
                    
                    @teachers.each do |teacher|
                        @email = User.where('id = ?', teacher.user_id).first
                        UserMailer.too_many_email(@email, @user).deliver
                    end
                end
            end
        end
    else
        @point = Point.where('id = ?', @student_point.point_id).first
        @guardians.each do |guardian|
            @email = User.where('id = ?', guardian.guardian_id).first
            UserMailer.appreciation_email(@email, @user, @point).deliver
        end
    end
    
    
    if @student_point.save
        respond_to do |format|
            format.html {
                redirect_to user_path(:id => @student_point.user_id), notice: 'Point was successfully saved for the student.'}
            format.js {
                redirect_to user_path(:id => @student_point.user_id), notice: 'Point was successfully saved for the student.'}
        end
        
    else
        respond_to do |format|
            format.html { render action: 'new' }
            format.js
        end
    end

  end
  
  
  def self.calcInitPoints(prev_term)
	  @setting = AlertSetting.select('penalty_carried_over, default_points').first
	  
	  @students = User.select(:id).where('school_id = ? AND type = 3', current_user.school_id)
      @point_id = Point.select(:id).where('school_id = ? AND points.key = 1', current_user.school_id)
	  @students.each do |user|
			StudentPoint.create!(:user_id => user.id, :point_id => @point_id.id, :assigned_points => @setting.default_points)
	  end	

	  @initialPoints = StudentPoint.select('user_id').group('user_id').where('assigned_points < 0').where('created_at >= ?', @prev_term.term_from).where('created_at <= ?', @prev_term.term_to).sum('assigned_points')
	  @initialPoints.each do |user_id, points|
			StudentPoint.create!(:user_id => user_id, :point_id => 2, :assigned_points => (((@setting.penalty_carried_over * points)/100) * -1).to_int)
	  end	
	  	
  end

    def points_all
        @point_options = Point.where('id != 1 and id != 2 and school_id = ?', current_user.school_id).map{|point| [point.description, point.credit, point.value, point.card_offense_id, point.id]}
    end

  private

    # Only allow a trusted parameter "white list" through.
    def student_point_params
      params.require(:student_point).permit(:user_id, :point_id, :assigned_points, :card_offense_id)
    end
end

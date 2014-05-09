class StudentPointsController < ApplicationController
  before_action :points_all
	
  # GET /student_points/new
  def new
    @student_point = StudentPoint.new
  end

  # POST /student_points
  def create
    @student_point = StudentPoint.new(student_point_params)
	
	#gets send_auto_email, min_points_required, min_points_for_penalty, max_warnings_before_email_alert, repetition_of_mistake_before_email
	@alert_settings = AlertSetting.first
	
	if @alert_settings.send_auto_email
		@user = User.where('id = ?', @student_point.user_id).first
		#calculate total points
		@current_term = Term.select('id, term_from, term_to').where('term_from <= ?', Time.now).order('term_from desc').first
		
		@total_positive_points = StudentPoint.where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @student_point.user_id, @current_term.term_from, @current_term.term_to).where(:is_credit => true).sum('assigned_points')
		@total_negative_points = StudentPoint.where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ?', @student_point.user_id, @current_term.term_from, @current_term.term_to).where(:is_credit => false).sum('assigned_points')
		
		@total_points = @total_positive_points - @total_negative_points
		
		# Send Alert for min points required
		if @total_points <= @alert_settings.min_points_required
			UserMailer.min_points_email(@user).deliver
		end
			
		unless @student_point.is_credit?
			@number_of_repetitions = StudentPoint.where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ? and point_id = ?', @student_point.user_id, @current_term.term_from, @current_term.term_to, @student_point.point_id).where(:is_credit => false).count
			if @number_of_repetitions > @alert_settings.repetition_of_mistake_before_email
				UserMailer.repetition_email(@user).deliver
			end
			
			if @student_point.assigned_points >= @alert_settings.min_points_for_penalty
				#find the number of serious felanies committed
				@number_of_serious_offences = StudentPoint.where('student_points.user_id = ? and student_points.created_at >= ? and student_points.created_at < ? and assigned_points <= ?', @student_point.user_id, @current_term.term_from, @current_term.term_to, @alert_settings.min_points_for_penalty).where(:is_credit => false).count
				if @number_of_serious_offences > @alert_settings.max_warnings_before_email_alert
					UserMailer.too_many_email(@user).deliver
				end
			end
		end

	end
	
    if @student_point.save
      redirect_to user_path(:id => @student_point.user_id), notice: 'Point was successfully saved for the student.'
    else
      render action: 'new'
    end
  end
  
  def points_all
  	@point_options = Point.where('id != 100 and id != 101').map{|point| [point.description, point.credit, point.value, point.id]	}
  end 
  
  def self.calcInitPoints(prev_term)
	@setting = AlertSetting.select('penalty_carried_over, default_points').first

	@initialPoints = StudentPoint.select('user_id').group('user_id').where(:is_credit => false).where('created_at >= ?', prev_term['term_from']).where('created_at <= ?', prev_term['term_to']).sum('assigned_points')
	@initialPoints.each do |user_id, points|
		StudentPoint.create!(:user_id => user_id, :point_id => 100, :is_credit => true, :assigned_points => @setting.default_points)
		StudentPoint.create!(:user_id => user_id, :point_id => 101, :is_credit => false, :assigned_points => ((@setting.penalty_carried_over * points)/100).to_int)
		@user = User.where('id = ?', user_id)
		UserMailer.min_points_email(@user).deliver
	end		
  end
  
  private

    # Only allow a trusted parameter "white list" through.
    def student_point_params
      params.require(:student_point).permit(:user_id, :point_id, :assigned_points, :is_credit)
    end
end

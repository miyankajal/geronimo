class StudentPointsController < ApplicationController
  before_action :points_all
	
  # GET /student_points/new
  def new
    @student_point = StudentPoint.new
  end

  # POST /student_points
  def create
    @student_point = StudentPoint.new(student_point_params)

    if @student_point.save
      redirect_to user_path(:id => @student_point.user_id), notice: 'Point was successfully saved for the student.'
    else
      render action: 'new'
    end
  end
  
  def points_all
  	@point_options = Point.all.map{|point| [point.description, point.credit, point.id]}
  end 
  
  def self.calcInitPoints(prev_term)
	@setting = AlertSetting.select('penalty_carried_over, default_points').first

	@initialPoints = StudentPoint.select('user_id').group('user_id').where(:is_credit => false).where('created_at >= ?', "2014-04-14 01:51:00").where('created_at <= ?', "2014-04-29 01:51:00").sum('assigned_points')
	@initialPoints.each do |user_id, points|
		StudentPoint.create!(:user_id => user_id, :point_id => 100, :is_credit => true, :assigned_points => @setting.default_points)
	end	
	
	@initialPoints = StudentPoint.select('user_id').group('user_id').where(:is_credit => false).where('created_at >= ?', "2014-04-14 01:51:00").where('created_at <= ?', "2014-04-29 01:51:00").sum('assigned_points')
	
	@initialPoints.each do |user_id, points|
		StudentPoint.create!(:user_id => user_id, :point_id => 101, :is_credit => false, :assigned_points => points)
	end	
  end
  
  private

    # Only allow a trusted parameter "white list" through.
    def student_point_params
      params.require(:student_point).permit(:user_id, :point_id, :assigned_points, :is_credit)
    end
end

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
  
  private

    # Only allow a trusted parameter "white list" through.
    def student_point_params
      params.require(:student_point).permit(:user_id, :point_id, :assigned_points, :is_credit)
    end
end

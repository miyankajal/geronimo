class PointsController < ApplicationController
  load_and_authorize_resource
  
  before_action :new
  before_action :set_point, only: [:show, :edit, :update, :destroy]
  before_action :card_offenses
  respond_to :html, :js

  # GET /points
  def index
    @points = Point.joins('INNER JOIN card_offense_types ON card_offense_types.id = points.card_offense_id').select('points.id AS point_id, points.credit, points.description, points.value, card_offense_types.description AS card_offense, points.id AS id, points.card_offense_id').where('school_id = ?', current_user.school_id)
  end

  # GET /points/1
  def show
	@point = Point.joins('INNER JOIN card_offense_types ON card_offense_types.id = points.card_offense_id').select('points.description, points.value, points.credit, card_offense_types.description AS card_offense, card_offense_types.id AS card_offense_id, points.id AS id, points.card_offense_id').where('points.id = ? AND school_id = ?', params[:id], current_user.school_id).first
	
	respond_to do |format|
      format.html
      format.js
      
      format.json {render :json => @point}
    end
  end

  # GET /points/new
  def new
    @point = Point.new
  end

  # GET /points/1/edit
  def edit
  end

  # POST /points
  def create
    @point = Point.new(point_params)
    @point_card_offense = CardOffenseType.select('description').where('id = ?', @point.card_offense_id).first
    if @point.save
        respond_to do |format|
            format.html {redirect_to points_path, notice: 'Point was successfully created.'}
            format.js
        end
    else
      render action: 'new'
    end
  end
  
  def get_card_desc
      @desc = CardOffenseType.select('description').where('id = ?', params[:id]).first
  end

  # PATCH/PUT /points/1
  def update
    if @point.update(point_params)
      redirect_to points_path, notice: 'Point was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /points/1
  def destroy
    @point.destroy
    respond_to do |format|
        format.html { redirect_to points_url, notice: 'Point was successfully destroyed.' }
        format.js
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point
      @point = Point.where('school_id = ?', current_user.school_id).find(params[:id])
    end
	
	def card_offenses
		@card_offense_options = CardOffenseType.all.map{|card_offense| [card_offense.description, card_offense.id]	}
	end

    # Only allow a trusted parameter "white list" through.
    def point_params
      params.require(:point).permit(:description, :value, :credit, :school_id, :card_offense_id)
    end
end

class GuardianshipsController < ApplicationController
  #before_action :set_guardianship, only: [:show, :edit, :update, :destroy]

  # GET /guardianships
  def index
    @guardianships = Guardianship.all
  end

  # GET /guardianships/1
  def show
  end

  # GET /guardianships/new
  def new
    @guardianship = Guardianship.new
  end

  # GET /guardianships/1/edit
  def edit
  end

  # POST /guardianships
  def create
    @guardianship = Guardianship.new(guardianship_params)

    if @guardianship.save
      redirect_to @guardianship, notice: 'Guardianship was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /guardianships/1
  def update
    if @guardianship.update(guardianship_params)
      redirect_to @guardianship, notice: 'Guardianship was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /guardianships/1
  def destroy
	@guardianship = Guardianship.find(params[:id])
    @guardianship.destroy
	redirect_to @guardianship, notice: 'Guardianship was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guardianship
      @guardianship = Guardianship.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def guardianship_params
      params.require(:guardianship).permit(:user_id, :guardian_id)
    end
end

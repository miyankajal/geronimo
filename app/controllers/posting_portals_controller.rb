class PostingPortalsController < ApplicationController
  before_action :set_posting_portal, only: [:show, :edit, :update, :destroy]

  # GET /posting_portals
  def index
    @posting_portals = PostingPortal.all
  end

  # GET /posting_portals/1
  def show
  end

  # GET /posting_portals/new
  def new
    @posting_portal = PostingPortal.new
  end

  # GET /posting_portals/1/edit
  def edit
  end

  # POST /posting_portals
  def create
    @posting_portal = PostingPortal.new(posting_portal_params)

    if @posting_portal.save
      redirect_to @posting_portal, notice: 'Posting portal was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /posting_portals/1
  def update
    if @posting_portal.update(posting_portal_params)
      redirect_to @posting_portal, notice: 'Posting portal was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /posting_portals/1
  def destroy
    @posting_portal.destroy
    redirect_to posting_portals_url, notice: 'Posting portal was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posting_portal
      @posting_portal = PostingPortal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def posting_portal_params
      params.require(:posting_portal).permit(:description)
    end
end

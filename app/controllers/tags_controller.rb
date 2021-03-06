class TagsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  def index
    @tags = Tag.all
  end

  # GET /tags/1
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      respond_to do |format|
          format.html { redirect_to tags_url, notice: 'Tag was successfully created.' }
          format.js
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /tags/1
  def update
	session[:return_to] ||= request.referer
	
    if @tag.update(tag_params)
      respond_to do |format|
			format.html { redirect_to @tags }
			format.json { render json: @tags }
	  end
    else
      render action: 'edit'
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    respond_to do |format|
        format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
        format.js
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:description, :school_id, :points)
    end
end

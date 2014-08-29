class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json
  
  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
	session[:return_to] ||= request.referer
    @comment = Comment.new(comment_params)

    if @comment.save
		respond_to do |format|
			format.html { redirect_to session.delete(:return_to) }
			format.json { render json: session.delete(:return_to)  }
		end
	end
  end

  # PATCH/PUT /comments/1
  def update
	session[:return_to] ||= request.referer
    if @comment.update(comment_params)
		respond_to do |format|
			format.html { redirect_to @comment }
			format.json { render json: @comment }
		end
    end
  end

  # DELETE /comments/1
  def destroy
	session[:return_to] ||= request.referer
    @comment.destroy
    redirect_to session.delete(:return_to), notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:comment, :idea_id, :user_id, :accepted)
    end
end

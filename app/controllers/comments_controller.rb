class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

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
      redirect_to session.delete(:return_to), notice: 'Comment was successfully created.'
    else
      redirect_to session.delete(:return_to), notice: 'Comment was not created.'
	end
  end

  # PATCH/PUT /comments/1
  def update
	session[:return_to] ||= request.referer
    if @comment.update(comment_params)
      redirect_to session.delete(:return_to), notice: 'Comment was successfully updated.'
    else
      render action: 'edit'
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
      params.require(:comment).permit(:comment, :idea_id, :user_id, :likes_count, :accepted)
    end
end

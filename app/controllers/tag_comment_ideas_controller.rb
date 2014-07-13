class TagCommentIdeasController < ApplicationController
  before_action :set_tag_comment_idea, only: [:show, :edit, :update, :destroy]

  # GET /tag_comment_ideas
  def index
    @tag_comment_ideas = TagCommentIdea.all
  end

  # GET /tag_comment_ideas/1
  def show
  end

  # GET /tag_comment_ideas/new
  def new
    @tag_comment_idea = TagCommentIdea.new
  end

  # GET /tag_comment_ideas/1/edit
  def edit
  end

  # POST /tag_comment_ideas
  def create
	session[:return_to] ||= request.referer
    
	@idea_id = tag_comment_idea_params[:idea_id]
	TagCommentIdea.where('idea_id = ?', @idea_id).delete_all
	
	@tag_selected = tag_comment_idea_params[:tag_id]

	@tag_selected.each do |id|
		  TagCommentIdea.create(:tag_id => id , :idea_id => @idea_id)
	end
	
	redirect_to session.delete(:return_to)

  end

  # PATCH/PUT /tag_comment_ideas/1
  def update
    if @tag_comment_idea.update(tag_comment_idea_params)
      redirect_to @tag_comment_idea, notice: 'Tag comment idea was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /tag_comment_ideas/1
  def destroy
	session[:return_to] ||= request.referer
    @tag_comment_idea.destroy
    redirect_to session.delete(:return_to)
  end

  def add_tag
	session[:return_to] ||= request.referer
	TagCommentIdea.create(:tag_id => params[:tag_id], :idea_id => params[:idea_id])
	redirect_to session.delete(:return_to)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_comment_idea
      @tag_comment_idea = TagCommentIdea.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_comment_idea_params
      params.require(:tag_comment_idea).permit(:comment_id, :idea_id, :tag_id => [])
    end
end

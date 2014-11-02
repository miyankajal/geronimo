  class CommentsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json
  
  # GET /comments
  def index
    if current_user.type != 2
      @comments = Comment.where(:accepted => true)
    else
      @comments = Comment.all
    end
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
    @comment.accepted = true
    
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
  
  def report_comment
	  session[:return_to] ||= request.referer
	
  	@idea_user = Idea.select(:user_id, :moderator_id).where('id = ?', params[:idea_id]).first
	
  	if @idea_user.moderator_id.nil?
  		@teacher = User.joins('INNER JOIN teacher_class_relationships ON users.class_id = teacher_class_relationships.class_section_id', 'LEFT OUTER JOIN users AS teacher ON teacher.id = teacher_class_relationships.user_id').select('teacher.username, teacher.id, teacher.email').where('users.id = ? AND teacher_role_id = 2', @idea_user.user_id).first
  		Comment.where(:id => params[:comment_id]).update(:accepted => false)
  		Idea.where(:id => params[:idea_id]).update({:moderator_id => @teacher.id})
  	else
  		@teacher = User.select('username, id, email').where('users.id = ?', @idea_user.moderator_id).first
  		Comment.where(:id => params[:comment_id]).update(:accepted => false)
  	end
	
  	#Send mail to moderator
  	UserMailer.report_idea_email(@teacher).deliver

  	redirect_to session.delete(:return_to)
  end
  
  def accept_comment
	  session[:return_to] ||= request.referer
  	Comment.where('id = ?', params[:comment_id]).update(:accepted => true, :updated_at => Date.today)
  	redirect_to session.delete(:return_to)
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

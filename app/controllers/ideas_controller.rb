class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :teachers_all
  before_action :teacher_class_all
  before_action :tags_all
  before_action :get_idea_tag
  before_action :portals_all
  
  # GET /ideas
  def index
	
	if current_user.type == 3 #if student
		@user_data = User.select(:class_id, :school_id).where('id = ?', current_user.id)
		
		if params[:portal_id] == '1'
			@ideas = Idea.all.joins('LEFT OUTER JOIN users AS users ON users.id = ideas.user_id', 'LEFT OUTER JOIN users AS moderator_user ON moderator_user.id = ideas.moderator_id').select('moderator_user.first_name AS moderator_user_first_name, moderator_user.last_name AS moderator_user_last_name, ideas.id, ideas.updated_at, idea, likes_count, tag_id, user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id').where('user_id = ?', current_user.id).order('accepted, ideas.created_at DESC')
		elsif params[:portal_id] == '2'
			@ideas = Idea.all.joins('INNER JOIN users AS users ON users.id = ideas.user_id').select('ideas.id, ideas.updated_at, idea, likes_count, tag_id, user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id').where('portal_id = 2 AND users.class_id = ? AND accepted = 1', current_user.class_id).order('ideas.created_at DESC')
		elsif params[:portal_id] == '3'
			@ideas = Idea.all.joins('INNER JOIN users AS users ON users.id = ideas.user_id').select('ideas.id, ideas.updated_at, idea, likes_count, tag_id, user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id').where('portal_id = 3 AND users.school_id = ? AND accepted = 1', current_user.school_id).order('ideas.created_at DESC')
		end

	elsif current_user.type == 2 #if teacher
		
		if params[:portal_id] == '2'
			@ideas = Idea.all.joins('LEFT OUTER JOIN users AS users ON users.id = ideas.user_id', 'LEFT OUTER JOIN users AS moderator_user ON moderator_user.id = ideas.moderator_id').select('moderator_user.first_name AS moderator_user_first_name, moderator_user.last_name AS moderator_user_last_name, ideas.id, ideas.updated_at, idea, likes_count, tag_id, user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id').where('portal_id = ? AND users.class_id = ? AND accepted = ?', params[:portal_id], params[:class_id], params[:accepted]).order('ideas.created_at DESC')
		elsif params[:portal_id] == '3'
			@ideas = Idea.all.joins('LEFT OUTER JOIN users AS users ON users.id = ideas.user_id', 'LEFT OUTER JOIN users AS moderator_user ON moderator_user.id = ideas.moderator_id').select('moderator_user.first_name AS moderator_user_first_name, moderator_user.last_name AS moderator_user_last_name, ideas.id, ideas.updated_at, idea, likes_count, tag_id, user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id').where('portal_id = ? AND users.school_id = ?', params[:portal_id], current_user.school_id).order('ideas.created_at DESC')
		end
		
	end
	
  end
  
  def get_idea_tag
	@idea_tags = Tag.joins(:tag_comment_ideas).select(:description).where('idea_id = 6')
  end
  
  def teacher_class_all
	@teacher_class_options = TeacherClassRelationship.joins(:class_section).select('class_sections.id, description').where('user_id = ?', current_user.id).map{|class_section| [class_section.description, class_section.id]}
  end
  
  def tags_all
	@tag_options = Tag.select('id, description').where('school_id = ?', current_user.school_id).map{|tag| [tag.description, tag.id]}
  end
  
  def portals_all
	@portal_options = PostingPortal.select('description, id').all.map{|portal| [portal.description, portal.id]}
  end
  
  def add_like
	session[:return_to] ||= request.referer
	Idea.where('id = ? AND user_id <> ?', params[:idea_id], current_user.id).update_all('likes_count = likes_count + 1')
	redirect_to session.delete(:return_to)
	#redirect_to get_portal_ideas_path(2,0,0)
  end
  
  def accept_idea
	session[:return_to] ||= request.referer
	Idea.where('id = ? AND moderator_id = ?', params[:idea_id], current_user.id).update_all(accepted: true)
	redirect_to session.delete(:return_to)
	#redirect_to get_portal_ideas_path(2,0,0)
  end
  


  # GET /ideas/1
  def show
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  def create
	session[:return_to] ||= request.referer
    @idea = Idea.new(idea_params)

    if @idea.save
	  @moderator = User.select(:username, :email).where('id = ?', @idea.moderator_id)
	  respond_to do |format|
			format.html { redirect_to session.delete(:return_to) }
			format.json { render json: session.delete(:return_to)  }
	  end
	  #UserMailer.new_idea_email(@moderator[0]).deliver
	  
      #redirect_to get_portal_ideas_path(1,0,0), notice: 'Idea was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /ideas/1
  def update
	session[:return_to] ||= request.referer
    if @idea.update(idea_params)
		respond_to do |format|
			format.html { redirect_to session.delete(:return_to) }
			format.json { render json: session.delete(:return_to)  }
		end
    else
      render action: 'edit'
    end
  end

  # DELETE /ideas/1
  def destroy
	session[:return_to] ||= request.referer
    @idea.destroy
    redirect_to session.delete(:return_to)
	#redirect_to get_portal_ideas_path(1,0,0), notice: 'Idea was successfully destroyed.'
  end

  def teachers_all
  	@moderator_options = User.select('id, first_name, last_name, email').where('type = 2 AND school_id = ?', current_user.school_id).map{|user| [user.first_name + ' ' + user.last_name, user.email, user.id]	}
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def idea_params
      params.require(:idea).permit(:idea, :user_id, :moderator_id, :likes_count, :tag_id, :portal_id, :accepted)
    end
end

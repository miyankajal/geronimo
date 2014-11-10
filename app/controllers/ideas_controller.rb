class IdeasController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :teachers_all
  before_action :teacher_class_all
  before_action :tags_all
  before_action :portals_all
  before_action :classes_all
  
  # GET /ideas
  def index
	
	if params[:tag_id] == '0'
		if current_user.type == 3 #if student
			@user_data = User.select(:class_id, :school_id).where('id = ?', current_user.id)
		
			if params[:portal_id] == '1'
				@ideas = Idea.all.joins('INNER JOIN users ON users.id = ideas.user_id', 'LEFT OUTER JOIN users AS moderator_user ON moderator_user.id = ideas.moderator_id').select('moderator_user.first_name AS moderator_user_first_name, moderator_user.last_name AS moderator_user_last_name, ideas.id, ideas.updated_at, idea, likes_count, tag_id, ideas.user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id, users.type AS user_type').where('ideas.user_id = ?', current_user.id).order('accepted, ideas.updated_at DESC')
			elsif params[:portal_id] == '2'
				@ideas = Idea.all.joins('INNER JOIN users AS users ON users.id = ideas.user_id').select('ideas.id, ideas.updated_at, idea, likes_count, tag_id, ideas.user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id, users.type AS user_type').where("(portal_id = 2 OR portal_id = 3) AND users.class_id = ?", current_user.class_id).where(:accepted => true).order('ideas.updated_at DESC')
			elsif params[:portal_id] == '3'
				@ideas = Idea.all.joins('INNER JOIN users AS users ON users.id = ideas.user_id').select('ideas.id, ideas.updated_at, idea, likes_count, tag_id, ideas.user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id, users.type AS user_type').where("portal_id = 3 AND users.school_id = ?", current_user.school_id).where(:accepted => true).order('ideas.updated_at DESC')
			end

		elsif current_user.type == 2 #if teacher
		
			if params[:portal_id] == '2'
				if params[:accepted] == '1'
					@ideas = Idea.all.joins('INNER JOIN users AS users ON users.id = ideas.user_id', 'LEFT OUTER JOIN users AS moderator_user ON moderator_user.id = ideas.moderator_id').select('moderator_user.first_name AS moderator_user_first_name, moderator_user.last_name AS moderator_user_last_name, ideas.id, ideas.updated_at, idea, likes_count, tag_id, ideas.user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id, users.type AS user_type').where("users.class_id = ?", params[:class_id]).where(:accepted => true).order('ideas.updated_at DESC')
				elsif params[:accepted] == '0'
					@ideas = Idea.all.joins('INNER JOIN users AS users ON users.id = ideas.user_id', 'LEFT OUTER JOIN users AS moderator_user ON moderator_user.id = ideas.moderator_id').select('moderator_user.first_name AS moderator_user_first_name, moderator_user.last_name AS moderator_user_last_name, ideas.id, ideas.updated_at, idea, likes_count, tag_id, ideas.user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id, users.type AS user_type').where("users.class_id = ?", params[:class_id]).where(:accepted => false).order('ideas.updated_at DESC')
				end
			elsif params[:portal_id] == '3'
				@ideas = Idea.all.joins('INNER JOIN users AS users ON users.id = ideas.user_id', 'LEFT OUTER JOIN users AS moderator_user ON moderator_user.id = ideas.moderator_id').select('moderator_user.first_name AS moderator_user_first_name, moderator_user.last_name AS moderator_user_last_name, ideas.id, ideas.updated_at, idea, likes_count, tag_id, ideas.user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id, users.type AS user_type').where('portal_id = ? AND users.school_id = ?', params[:portal_id], current_user.school_id).order('ideas.updated_at DESC')
			elsif params[:portal_id] == '0'
			  @ideas = Idea.all.joins('INNER JOIN users AS users ON users.id = ideas.user_id', 'LEFT OUTER JOIN users AS moderator_user ON moderator_user.id = ideas.moderator_id').select('moderator_user.first_name AS moderator_user_first_name, moderator_user.last_name AS moderator_user_last_name, ideas.id, ideas.updated_at, idea, likes_count, tag_id, ideas.user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id, users.type AS user_type').where('users.school_id = ? AND moderator_id = ?', current_user.school_id, current_user.id).where(:accepted => false).order('ideas.updated_at DESC')
			end
		end
	elsif params[:tag_id] != '0' && (current_user.type == 3 || current_user.type == 2)
		@ideas = Idea.all.joins('INNER JOIN users AS users ON users.id = ideas.user_id', 'INNER JOIN tag_comment_ideas ON tag_comment_ideas.idea_id = ideas.id').select('ideas.id, ideas.updated_at, idea, likes_count, tag_comment_ideas.tag_id, ideas.user_id, moderator_id, accepted, users.first_name, users.last_name, portal_id, users.type AS user_type').where('users.school_id = ? AND tag_comment_ideas.tag_id = ?', current_user.school_id, params[:tag_id]).where(:accepted => true).order('ideas.updated_at DESC')	
	end
	
  end
  
  def teacher_class_all
	@teacher_class_options = ClassSection.select('id, description').map{|class_section| [class_section.description, class_section.id]}
  end
  
  def tags_all
	if current_user.type == 2
		@tag_options = Tag.select('id, description').where('school_id = ?', current_user.school_id).map{|tag| [tag.description, tag.id]}
	elsif current_user.type == 3
		@tag_options = Tag.select('id, description').where('school_id = ? AND (points = 0 OR points IS NULL)', current_user.school_id).map{|tag| [tag.description, tag.id]}
	end
  end
  
  def portals_all
	@portal_options = PostingPortal.select('description, id').all.map{|portal| [portal.description, portal.id]}
  end
  
  def add_like
	session[:return_to] ||= request.referer
	@user_id = Idea.select('user_id, likes_count').where('id = ?', params[:idea_id]).first
	
	@user_idea_count = UserIdeaRelationships.where(:user_id => current_user.id, :idea_id => params[:idea_id]).count
	
	if @user_idea_count == 0
	
		UserIdeaRelationships.create(:user_id => current_user.id, :idea_id => params[:idea_id], :like => 't', :report => 'f')
		@current_term = Term.select('id, term_from, term_to').where('term_from <= ? AND school_id = ?', Time.now, current_user.school_id).order('term_from desc').first
		
		@student_point = StudentPoint.select('assigned_points, id').where('point_id = 31 and user_id = ? and created_at >= ? and created_at < ?', @user_id.user_id, @current_term.term_from, @current_term.term_to).order("student_points.created_at").first
				
		if @user_id.likes_count + 1 == 15
			if @student_point.empty?
				StudentPoint.create(:user_id => @user_id.user_id, :point_id => 31, :assigned_points => 5, :is_credit => 't' )
			else
				StudentPoint.where('id = ?', @student_point.id).update_all('assigned_points = assigned_points + 5')
			end
			Idea.where('id = ? AND user_id <> ?', params[:idea_id], current_user.id).update_all('portal_id = 3, likes_count = likes_count + 1, updated_at = NOW()')
		else
			if @student_point.nil?
				StudentPoint.create(:user_id => @user_id.user_id, :point_id => 31, :assigned_points => 1, :is_credit => 't' )
			else
				StudentPoint.where('id = ?', @student_point.id).update_all('assigned_points = assigned_points + 1')
			end
			Idea.where('id = ? AND user_id <> ?', params[:idea_id], current_user.id).update_all('likes_count = likes_count + 1')
		end
	end
	redirect_to session.delete(:return_to)
  end
  
  def report_idea
	session[:return_to] ||= request.referer
	
	UserIdeaRelationships.create(:user_id => current_user.id, :idea_id => params[:idea_id], :like => 'f', :report => 't')

	@idea_user = Idea.select(:user_id, :moderator_id).where('id = ?', params[:idea_id]).first
	
	if @idea_user.moderator_id.nil?
		@teacher = User.joins('INNER JOIN teacher_class_relationships ON users.class_id = teacher_class_relationships.class_section_id', 'LEFT OUTER JOIN users AS teacher ON teacher.id = teacher_class_relationships.user_id').select('teacher.username, teacher.id, teacher.email').where('users.id = ? AND teacher_role_id = 2', @idea_user.user_id).first
		Idea.where(:id => params[:idea_id]).update_all({:accepted => false, :moderator_id => @teacher.id})
	else
		@teacher = User.select('username, id, email').where('users.id = ?', @idea_user.moderator_id).first
		Idea.where(:id => params[:idea_id]).update_all(:accepted => false)
	end
	
	#Send mail to moderator
	UserMailer.report_idea_email(@teacher).deliver

	redirect_to session.delete(:return_to)

  end
  
  def accept_idea
	session[:return_to] ||= request.referer
	Idea.where('id = ? AND moderator_id = ?', params[:idea_id], current_user.id).update_all(:accepted => true, :updated_at => Date.today)
	redirect_to session.delete(:return_to)
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
	@idea.likes_count = 0
	if @idea.moderator_id.nil?
		@idea.portal_id = 2
		@idea.accepted = true
	else
		@moderator = User.select(:username, :email).where('id = ?', @idea.moderator_id).first
		UserMailer.new_idea_email(@moderator).deliver
	end
	
    if @idea.save
	  respond_to do |format|
		format.html { redirect_to session.delete(:return_to) }
		format.json { render json: session.delete(:return_to)  }
	  end
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
  
  def classes_all
	@class_options = ClassSection.where('school_id = ?', current_user.school_id).map{|class_section| [class_section.description, class_section.id]}
  end
 
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def idea_params
      params.require(:idea).permit(:idea, :user_id, :moderator_id, :likes_count, :tag_id, :portal_id, :accepted, :class_id)
    end
end

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
	
	
	
	unless user.nil?
		cannot :manage, :all do |current_user|
			user.school_id != current_user.school_id
		end

		if user.type == 1	# admin
			can :manage, :all 
			cannot :manage, Idea
			
		elsif user.type == 2	# teacher
			can :manage, :all 
				
		else	#student 	
			can :read, [User, Comment, Idea, Point]
			cannot :index, User
			can [:show, :edit, :update, :delete], User do |current_user|
				user.id == current_user.id
			end
			
			
			if user.type == 4	# guardian
				cannot :manage, Idea
			else
			  can :manage, [Idea, TagCommentIdea, Comment]
				cannot :show, User do |current_user|
					user.id != current_user.id
				end
			end
			
		end
	end
	
	
  end
end
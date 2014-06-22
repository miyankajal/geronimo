class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  # GET /schools
  def index
    @schools = School.all
  end

  # GET /schools/1
  def show
  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  def create
    @school = School.new(school_params)

    if @school.save
		
		#create default points
		Point.create(:id=>1, :description=>'Total Points to start with', :value=>1000, :credit=>true, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>2, :description=>'Points carried over from another year', :value=>0, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>3, :description=>'Marking providing extra study material (charts, models, slides, articles/reports etc.)', :value=>20, :credit=>true, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>4, :description=>'Classroom Duties of monitors for various tasks performed in a responsible way', :value=>25, :credit=>true, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>5, :description=>'Performing extra duties as and when applicable', :value=>25, :credit=>true, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>6, :description=>'Group tasks (for projects etc.)', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>7, :description=>'Bulletin Boards for winning class especially those who have worked for the board', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>8, :description=>'Participation in Inter House and Inter Class events', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>9, :description=>'Winning Inter School events', :value=>50, :credit=>true, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>10, :description=>'Honesty', :value=>25, :credit=>true, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>11, :description=>'Good Conduct', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>12, :description=>'Late Coming', :value=>10, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>13, :description=>'Speaking in Non-Campus Language', :value=>10, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>14, :description=>'Dining Room Misbehavior', :value=>25, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>15, :description=>'Talking during Assembly', :value=>50, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>16, :description=>'Bunking Class/Study', :value=>200, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>17, :description=>'Abusive Language', :value=>100, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>18, :description=>'Disobeying Office Bearers. This charge will be reported by respective Office Bearer to the concerned House Master/Mistress for entry', :value=>25, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>19, :description=>'Smoking/Drinking/Use of Drugs in School Premises', :value=>750, :credit=>false, :card_offense_id => 2, :school_id => @school.id)
		Point.create(:id=>20, :description=>'Possession of a Mobile Phone/SIM Card', :value=>500, :credit=>false, :card_offense_id => 4, :school_id => @school.id)
		Point.create(:id=>21, :description=>'Disobedience/Disrespect', :value=>50, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>22, :description=>'Cheating during Unit Tests/Terminal Exams', :value=>500, :credit=>false, :card_offense_id => 4, :school_id => @school.id)
		Point.create(:id=>23, :description=>'Destruction of School Property/Cases of Theft', :value=>150, :credit=>false, :card_offense_id => 3, :school_id => @school.id)
		Point.create(:id=>24, :description=>'Study Disturbance', :value=>20, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>25, :description=>'Untidiness', :value=>10, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>26, :description=>'Possession of Pornographic Material', :value=>500, :credit=>false, :card_offense_id => 4, :school_id => @school.id)
		Point.create(:id=>27, :description=>'Dormitory Misbehavior', :value=>20, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>28, :description=>'Sports Field Misbehavior', :value=>20, :credit=>false, :card_offense_id => 1, :school_id => @school.id)
		Point.create(:id=>29, :description=>'Ragging/Bullying', :value=>300, :credit=>false, :card_offense_id => 4, :school_id => @school.id)
		Point.create(:id=>30, :description=>'Extended Violent Behavior', :value=>250, :credit=>false, :card_offense_id => 3, :school_id => @school.id)

      redirect_to @school, notice: 'School was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /schools/1
  def update
    if @school.update(school_params)
      redirect_to @school, notice: 'School was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /schools/1
  def destroy
    @school.destroy
    redirect_to schools_url, notice: 'School was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def school_params
      params.require(:school).permit(:name, :address, :phone_no)
    end
end

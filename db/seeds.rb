# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

UserType.delete_all

UserType.create(:id=>1, :description=>'Admin')
UserType.create(:id=>2, :description=>'Teacher')
UserType.create(:id=>3, :description=>'Student')
UserType.create(:id=>4, :description=>'Guardian')


TeacherRole.delete_all

TeacherRole.create(:id=>1, :description=>'Restricted')
TeacherRole.create(:id=>2, :description=>'Class Teacher')
TeacherRole.create(:id=>3, :description=>'Subject Teacher')

CardOffenseType.create(:id=>1, :description=>'None')
CardOffenseType.create(:id=>2, :description=>'Red Card')
CardOffenseType.create(:id=>3, :description=>'Pink Card')
CardOffenseType.create(:id=>4, :description=>'Yellow Card')

AlertSetting.create!(:default_points=>1000, :min_points_required=>200, :send_auto_email=>true, :max_warnings_before_email_alert=>3, :min_points_for_penalty=>25, :repetition_of_mistake_before_email=>3, :penalty_carried_over=>10, :school_id => 1)

#First School
School.create!(:name => 'Geronimo Academy', :address => 'Canfield, Ohio, USA', :phone_no => '+1 0000000000')

#First user and make it the system admin
User.create!(:username => 'geronimo', :email => 'team.geronimo.inc@gmail.com', :first_name => 'Geronimo', :last_name => 'Admin', :password => '1234', :password_confirmation => '1234', :type => 1, :school_id => 1)


Point.delete_all
Point.create(:id=>1, :description=>'Total Points to start with', :value=>1000, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>2, :description=>'Points carried over from another year', :value=>0, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>3, :description=>'Marking providing extra study material (charts, models, slides, articles/reports etc.)', :value=>20, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>4, :description=>'Classroom Duties of monitors for various tasks performed in a responsible way', :value=>25, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>5, :description=>'Performing extra duties as and when applicable', :value=>25, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>6, :description=>'Group tasks (for projects etc.)', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>7, :description=>'Bulletin Boards for winning class especially those who have worked for the board', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>8, :description=>'Participation in Inter House and Inter Class events', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>9, :description=>'Winning Inter School events', :value=>50, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>10, :description=>'Honesty', :value=>25, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>11, :description=>'Good Conduct', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>12, :description=>'Late Coming', :value=>10, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>13, :description=>'Speaking in Non-Campus Language', :value=>10, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>14, :description=>'Dining Room Misbehavior', :value=>25, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>15, :description=>'Talking during Assembly', :value=>50, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>16, :description=>'Bunking Class/Study', :value=>200, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>17, :description=>'Abusive Language', :value=>100, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>18, :description=>'Disobeying Office Bearers. This charge will be reported by respective Office Bearer to the concerned House Master/Mistress for entry', :value=>25, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>19, :description=>'Smoking/Drinking/Use of Drugs in School Premises', :value=>750, :credit=>false, :card_offense_id => 2, :school_id => 1)
Point.create(:id=>20, :description=>'Possession of a Mobile Phone/SIM Card', :value=>500, :credit=>false, :card_offense_id => 4, :school_id => 1)
Point.create(:id=>21, :description=>'Disobedience/Disrespect', :value=>50, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>22, :description=>'Cheating during Unit Tests/Terminal Exams', :value=>500, :credit=>false, :card_offense_id => 4, :school_id => 1)
Point.create(:id=>23, :description=>'Destruction of School Property/Cases of Theft', :value=>150, :credit=>false, :card_offense_id => 3, :school_id => 1)
Point.create(:id=>24, :description=>'Study Disturbance', :value=>20, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>25, :description=>'Untidiness', :value=>10, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>26, :description=>'Possession of Erotica', :value=>500, :credit=>false, :card_offense_id => 4, :school_id => 1)
Point.create(:id=>27, :description=>'Dormitory Misbehavior', :value=>20, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>28, :description=>'Sports Field Misbehavior', :value=>20, :credit=>false, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>29, :description=>'Ragging/Bullying', :value=>300, :credit=>false, :card_offense_id => 4, :school_id => 1)
Point.create(:id=>30, :description=>'Extended Violent Behavior', :value=>250, :credit=>false, :card_offense_id => 3, :school_id => 1)
Point.create(:id=>31, :description=>'Idea Points', :value=>0, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>32, :description=>'Volunteer for Buddy Teacher', :value=>20, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>33, :description=>'Volunteer for Class Functions', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>34, :description=>'Volunteer for School Functions', :value=>20, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>35, :description=>'Showing initiative', :value=>25, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>36, :description=>'Leadership', :value=>25, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>37, :description=>'Taking responsibility without hesitation', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => 1)
Point.create(:id=>38, :description=>'Responsible Behavior', :value=>10, :credit=>true, :card_offense_id => 1, :school_id => 1)

PostingPortal.create(:id=>1, :description=>'None')
PostingPortal.create(:id=>2, :description=>'Class')
PostingPortal.create(:id=>3, :description=>'School')
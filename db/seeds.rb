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

AlertSetting.create!(:default_points=>1000, :min_points_required=>200, :send_auto_email=>true, :max_warnings_before_email_alert=>3, :min_points_for_penalty=>25, :repetition_of_mistake_before_email=>3, :penalty_carried_over=>10)

Point.create(:id=>1, :description=>'Total Points to start with', :value=>1000, :credit=>true)
Point.create(:id=>2, :description=>'Points carried over from another year', :value=>0, :credit=>false)
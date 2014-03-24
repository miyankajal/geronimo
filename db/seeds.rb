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

TeacherRole.create(:id=>1, :description=>'Class Teacher')
TeacherRole.create(:id=>2, :description=>'Not Class Teacher')
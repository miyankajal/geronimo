namespace :db do
	desc "Fill db with sample data"
	task populate: :environment do
	
		99.times do |n|
			username = Faker::Name.name
			email = "eg-#{n+1}@railstutorial.org"
			password = "1234"
			enroll_id = n+1
			User.create!(username: username, school_id: 1, enrollment_id: enroll_id, email: email, first_name: "fn", last_name: "ln", password: password, password_confirmation: password, type: 3, class_id: 1)
		end
		
		40.times do |n|
			username = Faker::Name.name
			email = "eg-#{n+201}@railstutorial.org"

			password = "1234"
			User.create!(username: username, school_id: 1, email: email, first_name: "fn", last_name: "ln", password: password, password_confirmation: password, type: 2)
		end
	end
end

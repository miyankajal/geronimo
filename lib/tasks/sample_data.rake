namespace :db do
	desc "Fill db with sample data"
	task populate: :environment do
		User.create!(username: "Example user", email: "a@a.a", first_name: "fn", last_name: "ln", password: "a", password_confirmation: "a", type: 1)
		
		99.times do |n|
			username = Faker::Name.name
			email = "eg-#{n+1}@railstutorial.org"
			password = "a"
			User.create!(username: username, email: email, first_name: "fn", last_name: "ln", password: password, password_confirmation: password, type: 3, class_id: 1)
		end
		
		40.times do |n|
			username = Faker::Name.name
			email = "eg-#{n+101}@railstutorial.org"
			password = "a"
			User.create!(username: username, email: email, first_name: "fn", last_name: "ln", password: password, password_confirmation: password, type: 2)
		end
	end
end
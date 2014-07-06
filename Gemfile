source 'https://rubygems.org'

gem 'rails', '~> 4.0.0'
gem 'railties' 
gem 'turbolinks'
gem 'devise', '3.0.0.rc'
gem 'kaminari'
gem 'roo'
gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'
gem 'mysql2'
gem 'roo'
gem 'foreigner'

gem 'jquery-rails'
gem 'bootstrap-sass', '2.0.0'
gem 'bcrypt-ruby', '3.1.2'
gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.5'
gem 'gravtastic', '>= 2.1.0'
#gem "amqp", "~> 1.3.0"
#gem "eventmachine", "1.0.3"
gem 'redis'
gem "chartkick"
gem "therubyracer"
gem "less-rails"
gem "twitter-bootstrap-rails"
gem 'bootswatch-rails'

#Background queue
gem 'resque', '~> 1.22.0', :require => "resque/server"
gem "resque-scheduler"
gem 'resque_mailer', '~> 2.2.6'

gem 'sunspot_rails'
gem 'sunspot_solr' 

group :development, :test do
  gem 'sqlite3', '1.3.7'
  gem 'rspec-rails', '2.9.0'
  gem 'guard-rspec', '0.5.5'
  
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0'
  gem 'activesupport', '~>4.0.0'
  gem 'coffee-rails', '~>4.0.0'
  gem 'uglifier', '1.2.3'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '1.4.0'
  gem 'cucumber-rails', '1.2.1', :require => false
  gem 'database_cleaner', '0.7.0'
  gem 'rb-fsevent', '0.4.3.1', :require => false
  gem 'growl', '1.0.3'
  gem 'guard-spork', '0.3.2'  
  gem 'spork', '0.9.0'
  gem 'launchy', '2.1.0'
end

group :production do
  gem 'pg', '0.12.2'
end

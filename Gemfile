source "https://rubygems.org"

ruby "2.3.1"

gem "autoprefixer-rails"
gem "delayed_job_active_record"
gem "flutie"
gem "jquery-rails"

gem 'bootstrap-sass', '~> 3.3.6'
gem "font-awesome-rails"
gem 'sass-rails', '>= 3.2'
gem 'd3-rails', "~>3.5.17"
# gem 'topojson-rails', '~> 1.6', '>= 1.6.19'

gem "normalize-rails", "~> 3.0.0"
gem "mysql2"
gem "puma"
gem "rails", "~> 5.0.0"
gem "recipient_interceptor"
gem "simple_form"
gem "sprockets", ">= 3.0.0"
gem "suspenders", "1.43"
gem "title"
gem "uglifier"
gem 'haml'

gem 'devise'
gem 'cancancan'
gem 'omniauth', '~> 1.3', '>= 1.3.2'
gem 'omniauth-facebook'
gem 'rails_admin', '~> 1.1', '>= 1.1.1'
gem 'paperclip', '~> 5.2.0'
gem 'andand', '~> 1.3', '>= 1.3.3'
gem 'highline', '~> 1.7', '>= 1.7.8'

gem "figaro"

group :development do
  gem "listen"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
  gem 'annotate', '~> 2.7', '>= 2.7.1'

  gem 'capistrano', '~> 3.1',     require: false
  gem 'capistrano-rvm',           require: false
  gem 'capistrano-rails',         require: false
  gem 'capistrano-passenger',     require: false
  gem 'capistrano-bundler',       require: false
  gem 'capistrano3-puma',         require: false
  gem 'capistrano-ext',           require: false
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.5.0.beta4"
  gem 'haml-rails', :group => :development
  gem 'faker', '~> 1.7', '>= 1.7.2'
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
  gem 'rails-controller-testing'
end

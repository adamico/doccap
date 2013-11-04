source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'mongoid', github: "mongoid/mongoid"
gem 'bson_ext'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jquery-turbolinks'
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Heroku gems
gem 'rails_12factor', group: :production
gem 'newrelic_rpm'
gem 'unicorn'
gem "unicorn-rails"
gem 'foreman'

gem 'bootstrap-sass', '~> 3.0.1.0.rc'
gem "devise", github: "plataformatec/devise"
gem 'simple_form', github: "plataformatec/simple_form"
gem "mongoid-paperclip", github: "meskyanichi/mongoid-paperclip", require: "mongoid_paperclip"
gem 'aws-sdk', '~> 1.3.4'
gem "paperclip-dropbox", ">= 1"
gem 'mongoid_taggable'
gem 'select2-rails', github: "argerim/select2-rails"

group :test, :development do
  gem "rspec-rails"
  gem "poltergeist", github: "jonleighton/poltergeist"
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "database_cleaner", github: "bmabey/database_cleaner"
  gem "guard-rspec", "~> 2.1.0"
  gem "simplecov", :require => false
  gem "mongoid-rspec"
end

group :development do
  gem "debugger"
  gem "pry-rails"
  gem "quiet_assets", ">= 1.0.1"
end

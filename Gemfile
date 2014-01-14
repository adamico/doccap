source 'https://rubygems.org'
ruby "2.1.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0.beta1'

gem 'mongoid', github: "mongoid/mongoid"
gem 'bson_ext'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'

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

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/jonleighton/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

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
#gem 'simple_form', github: "plataformatec/simple_form"
gem 'simple_form', github: 'zlx/simple_form_bootstrap3'
gem 'mongoid_taggable'
gem 'select2-rails', github: "argerim/select2-rails"
gem "cancan", github: "ncri/cancan", branch: "2.0"
gem "httparty"
gem "s3_direct_upload"
gem "fog"
gem 'unf'
gem 'responders'
gem 'ckeditor', github: "galetahub/ckeditor"
gem "mongoid-tree", github: "benedikt/mongoid-tree", branch: "mongoid-4.0"

group :test, :development do
  gem "rspec-rails"
  gem "poltergeist", github: "jonleighton/poltergeist"
  gem "dotenv-rails"
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "database_cleaner", github: "bmabey/database_cleaner"
  gem "guard-rspec", "~> 2.1.0"
  gem "simplecov", require: false
  gem "mongoid-rspec"
end

group :development do
  gem "pry-rails"
  gem "quiet_assets", ">= 1.0.1"
  gem 'better_errors'
  gem 'byebug'
  gem 'binding_of_caller', platforms: [:mri_19, :mri_20, :rbx]
  gem 'hub', require: nil
end

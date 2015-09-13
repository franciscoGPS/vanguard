source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2.1'
gem 'pg'                              # Use postgresql as the database for Active Record
gem 'sass-rails', '~> 5.0'            # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'            # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0'        # Use CoffeeScript for .coffee assets and views
gem 'therubyracer', platforms: :ruby  # See https://github.com/rails/execjs#readme for more supported runtimes
gem 'jquery-rails'                    # Use jquery as the JavaScript library
gem 'turbolinks'                      # Turbolinks makes following links in your web application faster.
gem 'jbuilder', '~> 2.0'              # Build JSON APIs with ease.
gem 'puma'                            # Use Puma as the app server
gem 'newrelic_rpm'                    # User NewRelic like performance monitor

group :production do
  gem 'rails_12factor'                  # Use rails_12factor to replaces the need for the plugins on Heroku
end

group :test do
  gem "rspec-rails", "~> 2.14"
  gem "factory_girl_rails"
  gem 'ffaker'
  gem "shoulda-matchers"
end

group :development, :test do
  gem 'byebug'                        # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'web-console', '~> 2.0'         # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'spring'                        # Spring speeds up development by keeping your application running in the background.
  gem 'mailcatcher'                   # Use mailcatcher to see mail in localhost:1080 (run "mailcatcher" in terminal to activate)
end
group :development do
  gem 'rails_layout'			      # Generate layout with framework (boostrap or foundation)
  gem 'bootstrap-sass-extras'		  # Generate news layouts with bootstrap theme
end

gem 'meta-tags'                       # Create SEO metatags
gem 'devise'                          # Auth Users
gem 'cancan'                          # Give rules & access to users
gem "paranoia", "~> 2.0"              # Use paranoia to make soft-delete objects
gem 'mandrill-api'                    # SMTP Settings
gem 'cocoon'                          # Use Cocoon for nested forms

gem 'bootstrap-sass', '~> 3.2.0'	  # Use bootstrap as CSS framework
gem 'autoprefixer-rails'			  # Precompile sass and prevent bugs (CSS)

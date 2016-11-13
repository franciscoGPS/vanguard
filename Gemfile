source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2.7.1'
gem 'pg'                              # Use postgresql as the database for Active Record
gem 'sass-rails', '~> 5.0'            # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'            # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0'        # Use CoffeeScript for .coffee assets and views
gem 'therubyracer', platforms: :ruby  # See https://github.com/rails/execjs#readme for more supported runtimes
gem 'jquery-rails'                    # Use jquery as the JavaScript library
gem 'turbolinks'                      # Turbolinks makes following links in your web application faster.
gem 'jquery-turbolinks'               # Complement for above turbolinks gem, that doesn't interfere with jquery.
gem 'jbuilder', '~> 2.0'              # Build JSON APIs with ease.
gem 'puma'                            # Use Puma as the app server
gem 'newrelic_rpm'                    # User NewRelic like performance monitor
gem 'sprockets-rails', :require => 'sprockets/railtie' # Use Sprockets to precompile assets
gem 'devise'                          # Auth Users


group :production do
  gem 'rails_12factor'                  # Use rails_12factor to replaces the need for the plugins on Heroku
  gem 'wkhtmltopdf-heroku'              # Wicked_pdf binaries for heroku

  gem 'wisepdf'                         # PDF library
end

group :test do
  gem 'rspec-rails', '~> 2.14'
  gem 'factory_girl_rails'

  gem 'ffaker'
  gem 'shoulda-matchers'
end

group :development, :test do
  gem 'byebug'                        # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'spring'                        # Spring speeds up development by keeping your application running in the background.
  gem 'mailcatcher'                   # Use mailcatcher to see mail in localhost:1080 (run 'mailcatcher' in terminal to activate)
  gem 'annotate'                      # Add a comment summarizing the current schema
end
group :development do
  gem 'rails_layout'			            # Generate layout with framework (boostrap or foundation)
  gem 'web-console', '~> 2.0'         # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'bootstrap-sass-extras'		      # Generate news layouts with bootstrap theme
  gem 'better_errors'                 # Replaces the standard Rails error page with a much better and more useful error page.
  gem 'binding_of_caller'             # Better Errors' advanced features (REPL, local/instance variable inspection, pretty stack frame names)
  gem 'rubocop', '~> 0.42.0', require: false # Code analyzer, based on the community Ruby style guide.
  gem 'brakeman', require: false   # Analysis security vulnerability scanner
end

gem 'rb-readline'                     # Provides a pure Ruby implementation of the GNU readline C library
gem 'meta-tags'                       # Create SEO metatags

gem 'cancan'                          # Give rules & access to users
gem 'paranoia', '~> 2.0'              # Use paranoia to make soft-delete objects
gem 'mandrill-api'                    # SMTP Settings
gem 'cocoon'                          # Use Cocoon for nested forms

gem 'bootstrap-sass', '~> 3.2.0'	    # Use bootstrap as CSS framework
gem 'autoprefixer-rails'			        # Precompile sass and prevent bugs (CSS)
gem 'font-awesome-sass', '~> 4.4.0'	  # Use font-awesome for icons
gem 'simple_calendar', '~> 1.1.0'     # Generate calendars with JQuery
gem 'aasm'                            # State Machine
# gem 'numbers_and_words', '~> 0.10.0'  # Number to word translater
gem 'number_to_words'                 # Number to spanish words
gem 'paperclip', '~> 4.3'             # Upload images
gem 'wicked_pdf'                      # A PDF generation plugin for Ruby on Rails
gem 'wkhtmltopdf-binary'              # Because wicked_pdf is a wrapper for wkhtmltopdf, you'll need to install that, too.
gem 'groupdate'                       # Generate more ActiveRecord methods
gem 'chartkick'                       # Charts with JS
gem 'ransack'                         # Ransack enables the creation of both simple and advanced search forms for your Ruby on Rails application
gem 'kaminari'                        # A Scope & Engine based paginator for modern web app frameworks and ORMs
gem 'kaminari-bootstrap'              # Basic Gem for quick default inclusion of Kaminari theme compatible with Twitter Bootstrap 2.0 and Twitter Bootstrap 3.0
gem 'public_activity'                 # Generate tracking of users
gem 'activerecord-session_store'      # Stores cookies on db insted of client. Useful when large ammount of data need to be stored.
gem 'bootstrap-table-rails'           # plugin  Rails engine to use it within the asset pipeline.
gem 'filterrific'                     # Filterrific is a Rails Engine plugin that makes it easy to filter, search, and sort your ActiveRecord lists
gem 'bootstrap-datepicker-rails'      # Project integrates a datepicker with Rails 3 assets pipeline.

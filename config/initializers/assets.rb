# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.initialize_on_precompile = true
Rails.application.config.assets.precompile += %w( home.css )
Rails.application.config.assets.precompile += %w( fonts.css )
Rails.application.config.assets.precompile += %w( main.css )
Rails.application.config.assets.precompile += ['bootstrap.css.scss']
Rails.application.config.assets.precompile += %w( filterrific/filterrific-spinner.gif )
Rails.application.config.assets.precompile += %w( sales_state_machine.js )
Rails.application.config.assets.precompile += %w( jquery-readyselector.js )

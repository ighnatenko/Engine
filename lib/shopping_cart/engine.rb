require 'rubygems'
require 'aasm'
require 'bootstrap-sass'
require 'cancancan'
require 'coffee-rails'
require 'country_select'
require 'devise'
require 'font-awesome-rails'
require 'haml'
require 'jquery-rails'
require 'draper'
require 'wicked'
require 'rectify'
require 'rails-i18n'
require 'sass-rails'
require 'simple_form'
require 'turbolinks'
require 'rspec-rails'
require 'faker'
require 'letter_opener'
require 'factory_bot_rails'
require 'rails-controller-testing'
require 'spring-commands-rspec'
require 'database_cleaner'

module ShoppingCart
  # Engine
  class Engine < ::Rails::Engine
    isolate_namespace ShoppingCart
    config.autoload_paths << File.expand_path('lib/shopping_cart/engine', __dir__)
  end
end

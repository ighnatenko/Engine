module ShoppingCart
  # InstallGenerator
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def require_stylesheets
      path_scss = 'app/assets/stylesheets/application.scss'
      if File.exist?(path_scss)
        open(path_scss, 'a') do |f|
          f.puts "@import 'shopping_cart/application';"
        end
        return
      end

      path_css = 'app/assets/stylesheets/application.css'
      return unless File.exist?(path_css)

      open(path_css, 'a') do |f|
        f.puts '*= require shopping_cart/application.css'
      end
    end

    def migrate
      rake 'shopping_cart:install:migrations'
      rake 'db:migrate'
    end

    def copy_locale
      en_path = ShoppingCart::Engine.root.join('config', 'locales', 'en.yml')
      copy_file en_path, 'config/locales/shopping_cart.en.yml'

      ru_path = ShoppingCart::Engine.root.join('config', 'locales', 'ru.yml')
      copy_file ru_path, 'config/locales/shopping_cart.ru.yml'
    end

    def add_views
      enginge_views =
        ShoppingCart::Engine.root.join('app', 'views', 'shopping_cart')
      directory enginge_views, 'app/views/shopping_cart'
    end

    def add_routes
      engine_route =
        "mount ShoppingCart::Engine => '/shopping_cart', as: 'shopping_cart'"
      return if File.readlines('config/routes.rb').join.include?(engine_route)
      route engine_route
    end

    def require_javascripts
      path = 'app/assets/javascripts/application.js'
      checkout_address = '//= require shopping_cart/checkout_address.js'
      checkout_delivery = '//= require shopping_cart/checkout_delivery.js'

      return if File.readlines(path).join.include?(checkout_address)
      inject_into_file(path, "#{checkout_address}\n",
                       before: '//= require_tree .')

      return if File.readlines(path).join.include?(checkout_delivery)
      inject_into_file(path, "#{checkout_delivery}\n",
                       before: '//= require_tree .')
    end
  end
end

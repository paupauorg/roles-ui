require 'less-rails'
require 'twitter-bootstrap-rails'

module RolesUi
  class Engine < ::Rails::Engine
    config.generators.integration_tool :rspec
    config.generators.test_framework :rspec

    initializer "roles_ui.initialize" do |app|
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :extend, RolesUi
      end
    end
  end
end

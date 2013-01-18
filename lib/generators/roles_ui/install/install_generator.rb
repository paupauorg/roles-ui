module RolesUi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      
      def install_ability
        copy_file 'ability.rb', 'app/models/ability.rb'
      end  
      
      def install_initializer
        copy_file 'roles_ui.rb', 'config/initializers/roles_ui.rb'
      end  
    end
  end
end
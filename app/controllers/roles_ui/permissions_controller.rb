module RolesUi
  class PermissionsController < RolesUi::ApplicationController
        
    def report
      @resources = RolesUi::Permission.used_resources.map{ |r| r == 'all' ? :all : r.constantize }
    end
  end  
end  
  
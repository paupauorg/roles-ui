module ActionDispatch::Routing
  class Mapper

    def routes_set
      scope :roles_ui, :module => :roles_ui do
        resources :roles

        match 'permissions_report' => 'permissions#report'
        match 'roles_ui' => 'roles#index'
      end
    end

    def mount_roles_ui(options = {})
      RolesUi.mount_point = options[:to]

      unless RolesUi.mount_point.blank?
        namespace RolesUi.mount_point, :module => nil do
          routes_set
        end
      else
        routes_set
      end

      # namespace RolesUi.mount_location do
      #   scope 'roles_ui', :module => :roles_ui do
      #     resources :roles
      #
      #     match 'permissions_report' => 'permissions#report'
      #     match '/' => 'roles#index'
      #   end
      # end
    end
  end
end

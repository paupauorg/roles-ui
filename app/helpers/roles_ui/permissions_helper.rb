module RolesUi
  module PermissionsHelper
    def permission_classes(permission)
      cls = 'class='
      if permission.cannot?
        cls << 'text-error'
      else
        cls << (permission.condition ? 'text-warning' : 'text-success')
      end
    end
  end
end
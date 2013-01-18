module RolesUi
  module UrlHelper
    def permissions_report_attrs
      { controller: 'roles_ui/permissions', action: :report }
    end

    def roles_index_attrs
      { controller: 'roles_ui/roles', action: :index }
    end

    def roles_new_attrs
      { controller: 'roles_ui/roles', action: :new }
    end

    def roles_edit_attrs(role)
      { controller: 'roles_ui/roles', action: :edit, id: role.id }
    end

    def roles_destroy_attrs(role)
      { controller: 'roles_ui/roles', action: :destroy }
    end

    def roles_form_attrs(role)
      attrs = { controller: 'roles_ui/roles' }
      if role.id
        attrs.merge({ id: role.id, action: :update, method: :put })
      else
        attrs.merge({ action: :create, method: :post })
      end
    end
  end
end
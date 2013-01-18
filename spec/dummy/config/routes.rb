RolesUiDemo::Application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  devise_for :backend_users, controllers: { sessions: 'sessions' }

  mount_roles_ui(to: 'backend')

  root to: 'home#index'
end


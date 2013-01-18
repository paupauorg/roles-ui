RolesUi.configure do |config|
  # config.user_classes = ['BackendUser', 'User']
  config.user_attributes = [:email, :admin, :created_at]
  # config.engine_layout = 'application'
  config.home_path = :root_path
end
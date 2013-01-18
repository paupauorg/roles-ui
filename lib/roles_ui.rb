require 'simple_form'
require 'roles_ui/engine'
require 'roles_ui/configure'
require 'roles_ui/user_extensions'
require 'roles_ui/version'
require 'roles_ui/rails/routes'

module RolesUi
  extend Configure

  mattr_accessor :mount_point
  @@mount_point = :roles_ui

  mattr_accessor :user_classes
  @@user_classes = ['User']
  def self.user_classes
    @@user_classes.map{ |uk| uk.constantize }
  end

  mattr_accessor :user_attributes
  @@user_attributes = [
    :email,
    :admin,
    :current_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_at,
    :last_sign_in_ip,
    :created_at,
    :updated_at]

  mattr_accessor :admin_roles

  mattr_accessor :home_path
  @@home_path = :roles_ui_path

  mattr_accessor :engine_layout
  @@engine_layout = 'roles_ui/application'

  def self.custom_layout?
    @@engine_layout != 'roles_ui/application'
  end

  def self.all_users
    RolesUi.user_classes.sort{ |x,y| x.name <=> y.name }.map{ |user_class| user_class.all }.flatten
  end

  # See RolesUi.authenticate_with
  DEFAULT_AUTHENTICATION = Proc.new do
    current_user and current_user.admin?
  end

  # Authenticate user to access to roles-ui controllers
  #
  # Usage:
  #
  # file config/initializers/roles_ui.rb
  #
  # RolesUi.authenticate_with do
  #   current_backend_user and current_backend_user.has_any_role?(:admin, :superadmin)
  # end
  def self.authenticate_with(&blk)
    @authenticate = blk if blk
    @authenticate || DEFAULT_AUTHENTICATION
  end

  def attach_roles
    include RolesUi::UserExtensions

    RolesUi::Role.all.each do |r|
      define_method("#{r.name}?"){ has_role?(r.name) }
    end rescue nil
  end
end

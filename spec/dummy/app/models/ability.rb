class Ability
  include CanCan::Ability
  attr_accessor :user

  def initialize(user)
    @user ||= user ||= User.new

    if @user.new_record?
      @user.roles << RolesUi::Role.find_by_name('no_role')
    end

    if @user.admin?
      can :manage, :all
    elsif !@user.has_any_role?
      # user without any role, skipped processing by roles
    else
      @user.roles.each do |role|
        role.permissions.each do |perm|
          resource = perm.resource == 'all' ? :all : perm.resource.constantize
          if perm.cannot?
            cannot perm.name.to_sym, resource, custom_conditions(perm.condition)
          else
            can perm.name.to_sym, resource, custom_conditions(perm.condition)
          end
          # puts_permission(perm)
        end
      end
    end
  end

  # puts_permission -- debug info
  def puts_permission(perm)
    puts "can#{perm.cannot? ? 'not' : nil} :#{perm.name.to_sym}, #{perm.resource}, #{custom_conditions(perm.condition).inspect}"
  end

  # custom conditions
  def self.all_conditions
    Ability.public_instance_methods.map{ |m| m if m.to_s.match(/^if_.*/)}.compact
  end

  # This method should accept a string  and trying to call method below
  # Method name must be started from 'if_'
  # Returns nil when the permission has no condition
  #
  # for exmaple, usual restrictions:
  #
  #   can :read, Project, :released => true
  #   can :read, Project, :preview => true
  #
  # custom conditions for these restrictions
  # should be:
  #
  #   def if_released_true; { released: true } end
  #   def if_preview_true; { preview: true } end

  def custom_conditions(condition=nil)
    send(condition.to_sym) if condition
  end

  def if_user_match_current_user
    { :user_id => @user.id }
  end
end
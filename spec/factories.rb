FactoryGirl.define do
  factory :admin, class: User do
    email 'admin@example.com'
    password 'secret'
    password_confirmation 'secret'
    admin      true
  end

  factory :user, class: User do
    email 'user@example.com'
    password 'secret'
    password_confirmation 'secret'
    admin false
  end

  factory :backend_user, class: BackendUser do
    email 'backend_user@example.com'
    password 'secret'
    password_confirmation 'secret'
    admin false
  end
  
  factory :role, class: RolesUi::Role do
    name 'role'
  end

  factory :no_role, class: RolesUi::Role do
    name 'no_role'
    after(:create) do |r|
      r.permissions.create(name: :read, resource: Milestone, priority: 1)
      r.permissions.create(name: :manage, resource: Timeentry, priority: 2, condition: :if_user_match_user)
    end
  end

  factory :provider, class: RolesUi::Role do
    name 'provider'
    after(:create) do |r|
      [Activity, Carrier, User, Client, Project, Setting, ContactSetting].each do |c|
        r.permissions.create(name: :manage, resource: c, priority: 1)
      end  

      r.permissions.create(name: :read, resource: Milestone, priority: 2)
      r.permissions.create(name: :read, resource: Contact, priority: 2)

      [:history, :email_history, :phone_history, :email_history, 
        :export_histories, :export_email, :export_phone].each do |action|
        r.permissions.create(name: action, resource: Contact, priority: 3)
      end 

      r.permissions.create(name: :manage, resource: Timeentry, priority: 4, condition: :if_user_match_user)
    end
  end

  factory :employee, class: RolesUi::Role do
    name 'employee'
    after(:create) do |r|
      r.permissions.create(name: :read, resource: User, priority: 1, condition: :if_self_match_user)
      r.permissions.create(name: :read, resource: Milestone, priority: 2)
      r.permissions.create(name: :manage, resource: Timeentry, priority: 2, condition: :if_user_match_user)
    end
  end

  factory :advisor, class: RolesUi::Role do
    name 'advisor'
    after(:create) do |r|
      r.permissions.create(cannot: true, name: :read, resource: Timeentry, priority: 1)
      r.permissions.create(name: :manage, resource: Timeentry, priority: 2, condition: :if_user_match_user)
      [Project, Milestone, Client].each do |c|
        r.permissions.create(name: :read, resource: c, priority: 3)
      end
      r.permissions.create(name: :read, resource: User, priority: 4, condition: :if_self_match_user)  
      r.permissions.create(name: :read, resource: Contact, priority: 5, condition: :if_owner_match)

      [:read,:create,:new,:show].each do |p|
        r.permissions.create(name: p, resource: Client, priority: 6, condition: :if_replacement_match_user)
        r.permissions.create(name: p, resource: Client, priority: 7, condition: :if_responsible_match_user)
      end
    end
  end

  factory :responsible, class: RolesUi::Role do
    name 'responsible'
    after(:create) do |r|
      r.permissions.create(name: :read, resource: User, priority: 1, condition: :if_self_match_user)
      r.permissions.create(name: :manage, resource: Client, priority: 2, condition: :if_responsible_match_user)
    end
  end

  factory :replacement, class: RolesUi::Role do
    name 'replacement'
    after(:create) do |r|
      r.permissions.create(name: :read, resource: User, priority: 1, condition: :if_self_match_user)
      r.permissions.create(name: :manage, resource: Client, priority: 2, condition: :if_replacement_match_user)
    end
  end
end
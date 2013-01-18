admin =( User.find_by_email('admin@example.com') || User.create(email: 'admin@example.com', password: 'secret'))
admin.update_attribute(:admin, true)
puts 'Admin added'

moderator =( User.find_by_email('moderator@example.com') || User.create(email: 'moderator@example.com', password: 'secret'))
puts 'Moderator added'

user_one =( User.find_by_email('user_one@example.com') || User.create(email: 'user_one@example.com', password: 'secret'))
puts 'User One added'

user_two =( User.find_by_email('user_two@example.com') || User.create(email: 'user_two@example.com', password: 'secret'))
puts 'User Two added'

puts 'Old roles destroyed' if RolesUi::Role.destroy_all

r = RolesUi::Role.create(name: :moderator)
[Post, Comment].each do |c|
  # can moderate all messages
  r.permissions.create(name: :manage, resource: c, priority: 1)
  # can read all resourses
  r.permissions.create(name: :read, resource: 'all', priority: 2)
end
moderator.roles << r
puts 'Moderator role created'

r = RolesUi::Role.create(name: :user)
[Post, Comment].each do |c|
  # can create new posts and Comments
  r.permissions.create(name: :create, resource: c, priority: 1)
  # can update own posts
  r.permissions.create(name: :update, resource: c, priority: 2, condition: :if_user_match_current_user)
  # can read all posts and comments
  r.permissions.create(name: :read, resource: c, priority: 3)
end
user_one.roles << r
user_two.roles << r
puts 'User role created'

puts 'Done!'

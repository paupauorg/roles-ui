$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'roles_ui/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'roles_ui'
  s.version     = RolesUi::VERSION
  s.authors     = ['']
  s.email       = ['contact@paupau.org']
  s.homepage    = 'http://roles-ui.paupau.org'
  s.summary     = 'Summary of RolesUi.'
  s.description = 'Roles UI is a graphic interface library for Ruby on Rails.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['CHANGELOG.rdoc', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  # s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 3.2.8'
  s.add_dependency 'devise'
  s.add_dependency 'cancan'
  s.add_dependency 'simple_form'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'twitter-bootstrap-rails'
  s.add_dependency 'less-rails'
  s.add_dependency 'i18n'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-spork'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'mysql2'
end

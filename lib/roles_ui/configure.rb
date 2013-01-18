require 'roles_ui'
require 'rails'

module RolesUi
  module Configure
    def configure
      yield self if block_given?
    end
  end
end    
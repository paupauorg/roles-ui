# encoding: UTF-8
module RolesUi
  class Assignment < ActiveRecord::Base
    belongs_to :localuser, :polymorphic => true
    belongs_to :role
  end
end

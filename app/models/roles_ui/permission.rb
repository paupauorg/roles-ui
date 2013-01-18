# encoding: UTF-8
module RolesUi
  class Permission < ActiveRecord::Base
    attr_accessible :name, :resource, :condition, :cannot, :priority, :role_id
    belongs_to :role
    
    validates_presence_of :name
    validates_uniqueness_of :name, :scope => [:role_id, :resource, :condition, :cannot]
    
    before_save :check_data
    
    def self.available_resources
      Rails.application.eager_load! if Rails.env.development?
      %w[all] + ActiveRecord::Base.descendants.map{ |c| c.name unless c.parent == RolesUi }.compact.sort
    end 
    
    def self.used_resources
      RolesUi::Permission.all.map(&:resource).compact.uniq.sort
    end
    
    def description
      [name.humanize, resource.humanize, (condition.humanize if condition)].compact.join(' ')
    end
    
    def action
      name.to_sym
    end
    
    private
    
    def check_data
      self.resource = resource.name if resource.is_a? Class
    end
  end
end
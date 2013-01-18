class Post < ActiveRecord::Base
  attr_accessible :name, :body

  belongs_to :user
  has_many :comments
end

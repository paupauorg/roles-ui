class Comment < ActiveRecord::Base
  attr_accessible :name, :body

  belongs_to :post
  belongs_to :user
end

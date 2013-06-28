class Comment < ActiveRecord::Base
  #attr_accessible :body, :table, :table_id
  attr_accessor :table, :table_id
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  belongs_to :location, :foreign_key => "commentable_id", :foreign_type => 'Location'
  validates :body, :presence => true
end

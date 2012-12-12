class Upload < ActiveRecord::Base
  attr_accessible :avatar, :uploadable_type, :uploadable_id, :title 
  has_attached_file :avatar, 
                    :storage => :s3,
                    :styles => { :big => "600x600>", :medium => "300x300>", :thumb => "100x100>" }, 
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":attachment/:id/:style.:extension",
                    :s3_permissions => :public_read,
                    :s3_protocol => 'https',
                    :s3_host_name => 's3-eu-west-1.amazonaws.com'
                    
  belongs_to :uploadable, :polymorphic => true
end

class Comment < ActiveRecord::Base
  
  mount_uploader :audio, AudioUploader
  belongs_to :user
  belongs_to :post
  
  
end

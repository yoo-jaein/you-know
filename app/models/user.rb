class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  has_many :posts, :dependent => :destroy
  has_many :comments
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  
  has_many :follower_relations, foreign_key: "followed_id", class_name: "Follow" 
  has_many :followers, through: :follower_relations, source: :follower 
  has_many :following_relations, foreign_key: "follower_id", class_name: "Follow" 
  has_many :followings, through: :following_relations, source: :followed


  
  
  def acts_like? (post)
   Like.find_by(user_id: self.id, post_id: post.id).present?
  end
  
  #def likes_count(post)
       #Post.likes.size
  #end
end

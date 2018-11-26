class Post < ActiveRecord::Base
   #validates :title, presence: true
    #validates_presence_of :title, on: :create
    #validate :, :on => :create
    #before_validation :title, :on => :create
    validates :title, :content, :presence =>true 
    
    #scope :jpub, ->{where(publish: 'wpdlwjq')}
    #scope :whats_new,->(pub){
        #where(publish: pub).order(published: :desc).limit(5)
    #}
    
    mount_uploader :image, PostImageUploader
   
    
    belongs_to :user
    #acts_as_commentable
    
    has_many :comments
    has_many :likes
    has_many :liked_users, through: :likes, source: :user
    has_many :impressions, :as=>:impressionable
    has_many :impressions, :as=>:impressionable
    is_impressionable :counter_cache => true, :unique => true
    
    has_many :likes_count, through: :likes, source: :post
    has_and_belongs_to_many :tags
    
     has_and_belongs_to_many :tags
    
    after_create do
        post =Post.find_by(id: self.id)
        hashtags=self.body.scan(/#\w+/)
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.delete('#'))
            post.tags << tag
        end
    end
    
    before_update do
        post = Post.find_by(id: self.id)
        post.tags.clear
        hashtags=self.body.scan(/#\w+/)
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.delete('#'))
            post.tags << tag
        end
    end 
    

    
    
def impression_count
       impressions.size
end
def unique_impression_count
       # impressions.group(:ip_address).size gives => {'127.0.0.1'=>9, '0.0.0.0'=>1}
       # so getting keys from the hash and calculating the number of keys
       impressions.group(:ip_address).size.keys.length #TESTED
end

def search(post)
    #@post= Post.find_by(post_id: params[:post_id])
    Like.find_by(post_id: post.id, like_count: 1).present?
    #Like.find_by(user_id: self.id, post_id: post.id).present?
end

end

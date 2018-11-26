class PostController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :help, :about, :premium]
  before_action :log_impression, :only=> [:show]
  respond_to :js, :json, :html
  
  def index
    #@post = Post.all.reverse
    #@post_0 = Post.where(category: params[:input_category])
    @post_1 = Post.where(category:1)
    @post_2 = Post.where(category:2)
    @post_3 = Post.where(category:3)
    @post_4 = Post.where(category:4)
    @post_5 = Post.where(category:5)
    @post_6 = Post.where(category:6)
    @post_7 = Post.where(category:7)

    @order_post = Post.order("impressions_count DESC")
    @recent_post = Post.order("created_at DESC")
   
    @hot_post =Post.joins("LEFT OUTER JOIN Likes ON likes.post_id = posts.id").group("posts.id").order("COUNT(likes.id) DESC")
                    
                    # AND likes.created_at >= DATETIME('now', '-1 day')
                    
                   
                #@hot_post = Post.all(:select => 'posts.*, count(like.id) as likes_count',
                #:joins => :likes,
                #:group => :posts,
                #:order => 'count DESC')
  end

  def user_info
    @user = User.find(params[:id])
    
    @post = Post.where(:user_id => params[:id])
    
    @comment = Comment.where(:user_id => params[:id])
    
    @like = Like.where(:user_id => params[:id])
  end
   
  def hashtags
    tag = Tag.find_by(name: params[:name])
    @posts = tag.posts  
  end
  
  def new
  end

  def create
    #uploader = PostImageUploader.new
    #uploader.store!(params[:image])
    
    @post = Post.new
    
    @post.title = params[:input_title]
    @post.content = params[:input_content]
    @post.video = params[:input_video]
    @post.category = params[:input_category]
    @post.image = params[:image]
    @post.body = params[:body]
    
    @post.user_id = current_user.id
    
   if @post.save
      redirect_to "/post/index"
   else
    render :new +flash[:notice] = "으으으으으ㅡㅇ"
   end
  end

  def update
    #uploader = PostImageUploader.new
    #uploader.store!(params[:image])
    
    @post = Post.find(params[:id])
    
    @post.title = params[:input_title]
    @post.content = params[:input_content]
    @post.video = params[:input_video]
    @post.category = params[:input_category]
    @post.image = params[:image]
    @post.likes_count = @post.likes_count
    
    @post.user_id = current_user.id
    
    @post.save
    
    redirect_to "/post/index"
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    
    if current_user.id == @post.user_id
      @post.destroy
      redirect_to "/post/index"
    else
      redirect_to "/post/index"
    end
  end

  def show
    @post = Post.find(params[:id])
    
    #@new_comment  = Comment.build_default_scope(@post, current_user.id,"")
    #@new_comment.audio = params[:audio]
  end
  
  def search
    @post = Post.where("title LIKE ? OR content LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%").reverse
  end
  
  def preview
    @post = Post.where(:category => params[:id])
  end
    
   def all_hot
     @hot_post =Post.joins("LEFT OUTER JOIN Likes ON likes.post_id = posts.id").group("posts.id").order("COUNT(likes.id) DESC")
   end
   
   def all_recent
     @recent_post = Post.order("created_at DESC")
   end
   
   def all_viewed
      @order_post = Post.order("impressions_count DESC")
   end
     @recent_post = Post.order("created_at DESC")
   
    
 
  def log_impression
     if current_user.present?
        @hit_post = Post.find(params[:id])
        # this assumes you have a current_user method in your authentication system
        @hit_post.impressions.create(ip_address: request.remote_ip, user_id:current_user.id)
       else
     end
  end
end



# class AddAttachmentAudioToComments < ActiveRecord::Migration
#   def self.up
#     change_table :comments do |t|
#       t.attachment :comments, :audio
#     end
#   end

#   def self.down
#     remove_attachment :comments, :audio
#   end
# end
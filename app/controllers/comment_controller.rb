class CommentController < ApplicationController
def create
    @comment = Comment.new
     #commentable = commentable_type.constantize.find(commentable_id)
     #@comment = Comment.build_from(commentable, current_user.id, body)
if current_user.nil?
 else
    @comment.content = params[:content]
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    @comment.username = params[:username]
    @comment.audio = params[:audio]
    @comment.save
 end
     
     redirect_to :back
end
     

  def destroy
     @comment = Comment.find(params[:id])
    
     if current_user.id == @comment.user_id
       @comment.destroy
       redirect_to :back
     else
       redirect_to :back
     end
  end
end
  


#private
  
  
  
 
      # def comment_params
      #   params[:comment][:user_id] = current_user.id
      #   params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id, :user_id, :nickname)
      # end
     
      # def commentable_type
      #   comment_params[:commentable_type]
      # end
     
      # def commentable_id
      #   comment_params[:commentable_id]
      # end
     
      # def comment_id
      #   comment_params[:comment_id]
      # end
     
      # def body
      #   comment_params[:body]
      # end
     
      # def make_child_comment
      #   return "" if comment_id.blank?
     
      #   parent_comment = Comment.find comment_id
      #   @comment.move_to_child_of(parent_comment)
      # end
#end
  
  
#end



 #def create
#     commentable = commentable_type.constantize.find(commentable_id)
#     @comment = Comment.build_from(commentable, current_user.id, body)
#     @comment.username = current_user.username
#     @comment.audio = params[:audio]
    
#     respond_to do |format|
#       if @comment.save
#         make_child_comment
#         format.html  { redirect_to(request.referrer, :notice => '댓글이 작성되었습니다.') }
#       else
#         format.html  { redirect_to(request.referrer, :alert => '댓글 내용을 작성해주세요.') }
#       end
#     end
# end
 
# def destroy
#       @comment = Comment.find_by(id: params[:id])
#       @comment.delete
#       respond_to do |format|
#         format.html { redirect_to(request.referrer, :notice => '댓글이 삭제되었습니다.')}
#         format.js
#       end
# end
 
#   private
  
#   def user_params
#   params.require(:comment).permit(:avatar)
#   end
 
#   def comment_params
#     params[:comment][:user_id] = current_user.id
#     params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id, :user_id, :nickname)
#   end
 
#   def commentable_type
#     comment_params[:commentable_type]
#   end
 
#   def commentable_id
#     comment_params[:commentable_id]
#   end
 
#   def comment_id
#     comment_params[:comment_id]
#   end
 
#   def body
#     comment_params[:body]
#   end
 
#   def make_child_comment
#     return "" if comment_id.blank?
 
#     parent_comment = Comment.find comment_id
#     @comment.move_to_child_of(parent_comment)
#   end
# end

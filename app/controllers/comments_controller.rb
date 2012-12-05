class CommentsController < ApplicationController
  def create
    if not logged_in?
      session[:return_to] = request.referer
      render :js => '$("#myModal").reveal();'
    else
      @commentable = params[:comment][:table].classify.constantize.find(params[:comment][:table_id])
      @comment = @commentable.comments.build(params[:comment])
      @partial = @comment.commentable_type.pluralize.downcase!
      @html_tag = params[:comment][:table]
      @comment.user_id = current_user.id
      @comment.save
    end
  end

  def destroy
    if not logged_in?
      session[:return_to] = request.referer
      render :js => '$("#myModal").reveal();'
    else
      comment = Comment.find(params[:id])
      if is_owner?(comment)
        comment.delete
      end
      render :nothing => true
    end
  end
end

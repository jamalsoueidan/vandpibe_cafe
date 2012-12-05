class RatingsController < ApplicationController
  def create
    if not logged_in?
      session[:return_to] = request.referer
      render :js => '$("#myModal").reveal();'
    else
      @commentable = params[:table_type].classify.constantize.find(params[:table_id])
    
      rating = params[:rating].to_i
    
      if rating == 1
        @comment = @commentable.ratings.build(:rating_key => params[:rating_key], :rating_value => rating)
        @comment.user_id = current_user.id
        @comment.save
      else
        @comment = @commentable.ratings.where(:rating_key => params[:rating_key], :user_id => 1).delete_all
      end
    
      @partial = params[:table_type].pluralize.downcase!
      @html_tag = params[:table_type]
    end
  end
end

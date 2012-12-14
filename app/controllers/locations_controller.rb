# -*- encoding : utf-8 -*-
class LocationsController < ApplicationController
  def toplist
    @locations = Location.best_rating
  end
  
  def show    
    name = params[:name].downcase
    name.utf8! if not Location.exists?(:name => name)
    options = {:name => name}
    if params[:city_name] == 'valby'
      options[:city_id] = City.select(:id).where(:name => params[:city_name]).first.id
    end

    @location = Location.includes(:city, :comments => [:user, :ratings], :tobaccos => :brand).where(options).first
    @city = @location.city    
    
    @comment_ids = @location.comment_ids
    
    @user_rate = {}
    @user_rate[:service] = Rating.average_by_key('rate_service', @comment_ids, 'Comment')
    @user_rate[:waterpipe] = Rating.average_by_key('rate_waterpipe', @comment_ids, 'Comment')
    @user_rate[:furniture] = Rating.average_by_key('rate_furniture', @comment_ids, 'Comment')
    @user_rate[:mood] = Rating.average_by_key('rate_mood', @comment_ids, 'Comment')
  end

  def destroy
    if not logged_in?
      session[:return_to] = request.referer
      render :js => '$("#myModal").reveal();'
    else
      if params[:comment_id]
        @comment = Comment.find(params[:comment_id])
        @location = @comment.location
        if @comment.user_id == current_user.id
          @comment.destroy
        end
      end
    end
  end
  
  def create
    if not logged_in?
      session[:return_to] = request.referer
      render :js => '$("#myModal").reveal();'
    else
      @spacer = true
      @location = Location.includes(:comments).find(params[:comment][:table_id])
      @comment = @location.comments.build(params[:comment])
      @comment.user_id = current_user.id
      @comment.save
      
      keys = ['rate_service', 'rate_waterpipe', 'rate_furniture', 'rate_mood']
      if !current_user.ratings.has_rated?(:rating_key => keys, :rating_id => @location.comment_ids, :rating_type => 'Comment')
        keys.each do |key|
          value = params[:comment][key].to_i
          if value > 0
            @rating = @comment.ratings.build(:rating_key => key, :rating_value => value)        
            @rating.user_id = current_user.id
            @rating.save
          end
        end
      end
      
    end
  end
end
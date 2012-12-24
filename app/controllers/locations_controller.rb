# -*- encoding : utf-8 -*-
class LocationsController < ApplicationController
  
  before_filter :authorize, :only => [:destroy]
  
  def toplist
    @locations = Location.best_rating
  end

  def show    
    @city = City.find_by_url(params[:city_name])
    @location = @city.locations.include_all.find_by_url(params[:name])
    @user_rate = @location.user_ratings
    @nearest = Location.where(:city_id => @city.id).order('RAND()').first
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
  
  def random
    @locations = Location.order('RAND()').limit(4)
    render :layout => false
  end
  
  def create
    @spacer = true
    @location = Location.includes(:comments).find(params[:comment][:table_id])
    @comment = @location.comments.build(params[:comment])
    if not logged_in?
      @comment.user = User.annonym
    else
      @comment.user = current_user
    end
    @comment.save
  end
end
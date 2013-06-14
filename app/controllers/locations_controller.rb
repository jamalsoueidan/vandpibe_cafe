# -*- encoding : utf-8 -*-
class LocationsController < ApplicationController
  before_filter :authorize, :only => [:destroy, :create, :write_review]
  
  after_filter :set_login_return_path, :only => [:toplist, :show]

  caches_page :toplist

  def toplist
    @locations = Location.sort_by("rating").limit(10)
  end

  def show
    @city = City.find_by_url(params[:city_name])
    @location = @city.locations.include_all.find_by_url(params[:name])
    
    if @location.nil?
      redirect_to root_path
    end

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

  def write_review
    show
  end

  def random
    @locations = Location.where(:visible => true).order('RAND()').limit(4)
    render :layout => false
  end

  def new_comment
    @location = Location.find(params[:id])
    @city = @location.city
    
  end

  def create
    @location = Location.find(params[:comment][:table_id])

    flash[:notice] = "Din anmedelse er nu tilføjet!"

    if params[:comment][:body].length > 5
      @comment = @location.comments.build(params[:comment])
      @comment.user = current_user
      @comment.save
    end

    params[:scores].each do |key, value|
      if value.to_i > 0
        if !@location.ratings.exists?(:rating_key => key, :user_id => current_user.id)
          @location.ratings.create(:rating_key => key, :rating_value => value, :user_id => current_user.id)
        end
      end
    end
  end
end

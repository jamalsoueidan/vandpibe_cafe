# -*- encoding : utf-8 -*-
class LocationsController < ApplicationController
  before_filter :authorize, :only => [:destroy, :create, :write_review]

  after_filter :set_login_return_path, :only => [:toplist, :show]

  def toplist
    @locations = Location.order('rating DESC').limit(10)
  end

  def show
    update_ratings
    @location = Location.unscoped.find_by_url(params[:name], params[:city_name]).first
    if @location.nil?
      redirect_to root_path
    end

    @comments = @location.comments.order('id DESC').includes(:user).paginate(:per_page => 7, :page => params[:page])
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

    if params[:comment] && params[:comment][:body]
      flash[:notice] = "Din kommentare er nu tilføjet!"
      if params[:comment][:body].length > 5
        @comment = @location.comments.build(comment_params)
        @comment.user = current_user
        @comment.save
      end
    end

    if params[:score]
      flash[:notice] = "Din bedømmelse er allerede tilføjet!"
      value = params[:score]
      if value.to_i > 0
        if !@location.ratings.exists?(:rating_key => 'location', :user_id => current_user.id)
          flash[:notice] = "Din bedømmelse er nu tilføjet!"
          @location.ratings.create(:rating_key => 'location', :rating_value => value, :user_id => current_user.id)
        end
      end
    end

  end

  private
    def update_ratings
      schedule = Schedule.where("created_at >= :since_yesterday", :since_yesterday => Time.now - 1.day).first
      if schedule.nil?
        Location.all.each do |location|
          ratings = [0,0,0,0,0]
          location.ratings.each do |rating|
            rate = rating.rating_value.to_i
            ratings[(rate-1)] += 1
          end

          left = 0.0
          right = 0.0
          ratings.each_index do |index|
            multiply = index+1
            left += ratings[index] * multiply
            right += ratings[index]
          end

          if left > 0 && right > 0
            scoring = Score.calculate(ratings)
            location.update_attribute(:rating, scoring)
          end
        end
        Schedule.new.save
      end
    end

    def comment_params
      params.require(:comment).permit(:body, :table_id)
    end
end

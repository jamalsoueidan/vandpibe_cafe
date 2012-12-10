class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :logged_in?, :is_owner?, :current_path
  
  before_filter :set_view_path
  
  def set_view_path
    prepend_view_path 'app/views/human/'
  end
  
  def robot?
    request.user_agent =~ /(Baidu|bot|Google|SiteUptime|Slurp|WordPress|ZIBB|bing|bingbot|ZyBorg)/i
  end
  
  def current_path
    request.path
  end
  
  def set_cities 
    @cities = City.order('name')
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id]) if User.exists?(session[:user_id])
    end
  end
  
  def authorize
    unless logged_in?
      redirect_to login_path
    end
  end
  
  def is_owner?(object)
    logged_in? && object.user_id == current_user.id
  end
end

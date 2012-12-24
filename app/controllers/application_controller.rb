class ApplicationController < ActionController::Base
  protect_from_forgery
    
  helper_method :current_user, :logged_in?, :is_owner?, :current_path
  before_filter :set_view_path
  
  def set_view_path
    if is_robot?
      prepend_view_path 'app/views/robot/'
    elsif is_mobile?
      prepend_view_path 'app/views/mobile/'
    else
      prepend_view_path 'app/views/web/'
    end
  end
  
  def is_robot?
    request.user_agent =~ /(Baidu|bot|Google|SiteUptime|Slurp|WordPress|ZIBB|bing|bingbot|ZyBorg)/i
  end
  
  def is_mobile?
    request.user_agent =~ /(palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|mobile)/i
  end
  
  def current_path
    request.path
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
    true
  end
  
  def authenticate_admin!
    unless logged_in? && current_user.is_admin?
      redirect_to login_path
    end
  end

  def is_owner?(object)
    logged_in? && object.user_id == current_user.id
  end

end

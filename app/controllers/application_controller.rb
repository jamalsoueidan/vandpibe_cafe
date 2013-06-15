class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :is_owner?, :current_path
  before_filter :set_view_path

  MOBILE = 'http://m.' + ActionMailer::Base.default_url_options[:host]

  before_filter :update_cache_location

  def update_cache_location
    if request.subdomain.empty? || request.subdomain == 'www'
      ActionController::Base.page_cache_directory = "#{Rails.root}/public/cache/web"
    else
      ActionController::Base.page_cache_directory = "#{Rails.root}/public/cache/mobile"
    end
  end

  def set_view_path
    if request.subdomain == 'm'
      prepend_view_path 'app/views/mobile/'
    else
      if is_mobile? && !is_ipad?
        if request.subdomain != 'm'
          redirect_to MOBILE
        end
        prepend_view_path 'app/views/mobile/'
      else
        prepend_view_path 'app/views/web/'
      end
    end
  end

  def is_robot?
    request.user_agent =~ /(Baidu|bot|Google|SiteUptime|Slurp|WordPress|ZIBB|bing|bingbot|ZyBorg)/i
  end

  def is_mobile?
    request.user_agent =~ /(palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile)/i
  end

  def is_ipad?
    request.user_agent =~ /ipad/i
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

  # http://mrdanadams.com/2011/exclude-active-admin-js-css-rails/#.UNi7ionjlA8
  def register_default_assets
    register_stylesheet 'active_admin.css'
    register_javascript 'active_admin.js'
  end

  def set_login_return_path
    session[:return_to] = request.fullpath
  end
end

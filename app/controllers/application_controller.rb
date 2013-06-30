class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :is_owner?, :current_path

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

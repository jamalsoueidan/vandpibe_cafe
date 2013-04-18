class MainController < ApplicationController
  
  before_filter :set_cities, :only => :index
  
  caches_page :sitemap
  
  def auth_js
    render :layout => false
  end
  
  def get_json
    city_id = params[:city_id].to_i
    location_id = params[:location_id].to_i
    
    options = {:only => [:latitude, :longitude, :id, :description, :name], :include => {:city => {:only => [:name, :color, :latitude, :longitude]}}}

    if location_id > 0
      render :json => Location.where(:id => location_id).to_json(options)
    else
      if city_id > 0 
        render :json => City.find(city_id).locations.to_json(options)
      else
        render :json => Location.all.to_json(options)
      end
    end
  end
  
  def sitemap
    @cities = City.all
    @questions = Question.all
  end
  
  def auth
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if user.nil?
      user = User.omniauth(auth)
      user.save
    end
    
    session[:user_id] = user.id
    flash[:notice] = "Du er nu logget paa :)"
    #flash[:notice] = "Authentication successful"
    if session[:return_to].nil?
      redirect_to "/" #render :xml => request.env["omniauth.auth"].to_xml
    else
      return_to = session[:return_to]
      session[:return_to] = nil
      redirect_to return_to
    end
  end
  
  def contact
    if request.post?
      TestMailer.contact(params[:contact]).deliver
    end
  end
  
  def login
  end
  
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end

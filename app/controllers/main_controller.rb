class MainController < ApplicationController

  def auth_js
    render :layout => false
  end

  def get_json
    city_name = params[:city_name]
    location_id = params[:location_id].to_i

    options = {:only => [:latitude, :longitude, :id, :description, :name, :city, :country]}

    if location_id > 0
      render :json => Location.where(:id => location_id).to_json(options)
    else
      unless city_name.nil?
        render :json => Location.where(:city => city_name).to_json(options)
      else
        render :json => Location.all.to_json(options)
      end
    end
  end

  def sitemap
    @cities = City.all
    #@questions = Question.all

    render :layout => false
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
      logger.info " => " + return_to
      redirect_to return_to
    end
  end

  def contact
    if request.post?
      TestMailer.contact(params[:contact]).deliver
    end
  end

  def login
    if params['return']
      session[:return_to] = params['return']
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end

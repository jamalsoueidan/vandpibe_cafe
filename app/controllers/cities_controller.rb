class CitiesController < ApplicationController
  before_filter :set_cities
  
  caches_page :index, :show
  
  def index  

  end
  
  def show
    @city = City.includes(:locations => :uploads).find_by_url(params[:name])
  end
  
  private
    def set_cities
      @cities = City.where(:visible => true)
    end
end

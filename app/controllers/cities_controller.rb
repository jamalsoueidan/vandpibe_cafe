class CitiesController < ApplicationController
  before_filter :set_cities
  
  def index  
  end
  
  def show
    @city = City.joins(:locations).find_by_url(params[:name])
  end
end

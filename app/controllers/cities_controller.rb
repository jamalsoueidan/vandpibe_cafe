class CitiesController < ApplicationController
  before_filter :set_cities
  
  def index  
  end
  
  def show
    name = params[:name].downcase
    name.utf8! if not City.exists?(:name => name)
    @city = City.find_by_name(name)
  end
end

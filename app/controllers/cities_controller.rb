class CitiesController < ApplicationController
  after_filter :set_login_return_path, :only => [:index, :show]

  def index
    @countries = Country.all
    @country = @countries.first
    @cities = @country.cities
    @city = @cities.order("RAND()").first
    @locations = @city.locations.where('locations.visible=1').includes(:uploads).order('RAND()')
  end

  def old_url
    redirect_to city_path(params[:city])
  end

  def show
    @city = City.find_by_url(params[:name])
    @country = @city.country
    @countries = Country.all
    @cities = @country.cities
    @locations = @city.locations.where('locations.visible=1')includes(:uploads).sort_by(params[:sort])

    if @city.nil?
      redirect_to root_path
    end
  end
end

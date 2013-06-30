class CitiesController < ApplicationController
  before_filter :set_cities

  after_filter :set_login_return_path, :only => [:index, :show]

  def index
    @locations = Location.includes(:uploads, :city).order('RAND()').limit(8)
  end

  def old_url
    redirect_to city_path(params[:city])
  end

  def show
    @city = City.find_by_url(params[:name])
    @locations = @city.locations.includes(:uploads).sort_by(params[:sort])

    if @city.nil?
      redirect_to root_path
    end
  end

  private
    def set_cities
      @countries = Country.includes(:cities)
    end
end

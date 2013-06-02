class CitiesController < ApplicationController
  before_filter :set_cities

  caches_page :index, :show

  def index

  end

  def old_url
    redirect_to city_path(params[:city])
  end

  def show
    @city = City.find_by_url(params[:name])
    @locations = Location.where(:city_id => @city.id).sort_by(params[:sort])

    if @city.nil?
      redirect_to root_path
    end
  end

  private
    def set_cities
      @countries = Country.order(:name)
      @cities = City.where(:visible => true).order(:name)
    end
end

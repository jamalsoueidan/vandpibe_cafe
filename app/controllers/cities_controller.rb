class CitiesController < ApplicationController
  before_filter :set_cities

  caches_page :index, :show

  def index

  end

  def old_url
    redirect_to city_path(params[:city])
  end

  def show
    @city = City.includes(:locations => :uploads).find_by_url(params[:name])
    if @city.nil?
      redirect_to root_path
    end
  end

  private
    def set_cities
      @cities = City.where(:visible => true)
    end
end

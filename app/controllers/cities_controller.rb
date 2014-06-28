class CitiesController < ApplicationController
  after_filter :set_login_return_path, :only => [:index, :show]
  before_filter :set_cities

  def old_url
    redirect_to city_path(params[:city])
  end

  def show
    @locations = Location.visible.where('city=?', params[:name]).includes(:uploads).sort_by(params[:sort])

    @city = params[:name].titleize
    unless @locations.empty?
      @city = @locations.first.city.titleize
    end
  end

  def set_cities
    @cities = Location.select(:city).visible.by_country('danmark').group(:city)
  end
end

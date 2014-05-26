class CitiesController < ApplicationController
  after_filter :set_login_return_path, :only => [:index, :show]

  def index
    @cities = Location.select(:city).where('visible=1').group(:city)
  end

  def old_url
    redirect_to city_path(params[:city])
  end

  def show
    @cities = Location.select(:city).where('visible=1').group(:city)
    @locations = Location.where('locations.visible=1 && city=?', params[:name]).includes(:uploads).sort_by(params[:sort])
  end
end

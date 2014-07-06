class CitiesController < ApplicationController
  after_filter :set_login_return_path, :only => [:index, :show]

  def old_url
    redirect_to city_path(params[:city])
  end

  def index
    @locations = Location.visible.limit(4).includes(:uploads).order('ID desc')
  end

  def show
    @locations = Location.visible.where('city=?', params[:name]).includes(:uploads).sort_by(params[:sort])

    @city = params[:name].titleize
    unless @locations.empty?
      @city = @locations.first.city.titleize
    end
  end
end

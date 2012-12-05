# -*- encoding : utf-8 -*-
class CitiesController < ApplicationController
  before_filter :set_cities
  
  def show
    name = params[:name].downcase
    name.utf8! if not City.exists?(:name => name)
    @city = City.find_by_name(name)
    
    content_for(:title, @city.name.big + " Cafe Oversigt")
    content_for(:meta_title, @city.name.big + " Cafe Oversigt ")
    content_for(:meta_description, "Oversigt over alle Vandpibe Cafeer i " + @city.name.big + ". Info omkring Åbningstider, Tobak, Vandpibe, Bedste Cafe? osv.")
  end
end

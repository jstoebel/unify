class PlacesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :json
  layout 'map'
  def index
  end

  def active
    places = Place.all.where(:active => true)
    render :json => places
  end

end

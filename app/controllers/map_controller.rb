class MapController < ApplicationController
  before_action :authenticate_user!

  def main
      # select country on the map
  end

  def checkout
      # grab the place and confirm
      # @place = Place.find_by :code => params[:place_code]
      # if @place.blank?
      #     redirect_to :controller => :map,
      #         :action => :main,
      #         :alert => "Place not found"
      # end
  end

  def confirm
  end

end

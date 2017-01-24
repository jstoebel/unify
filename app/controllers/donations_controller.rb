class DonationsController < ApplicationController
  before_action :authenticate_user!

  def new
    # grab the place and confirm
    @place = Place.find_by :code => params[:place]
    if @place.blank?
        redirect_to :controller => :map,
            :action => :main,
            :alert => "Place not found"
    end
    @donation = Donation.new({:user_id => current_user.id,
      :place_id => @place.id
      })
  end

  def create
  end

end

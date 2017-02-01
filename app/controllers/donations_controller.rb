class DonationsController < ApplicationController
  before_action :authenticate_user!

  def new
    # grab the place and confirm
    @user = current_user
    @place = Place.find_by :code => params[:place]
    if @place.blank?
        redirect_to :controller => :map,
            :action => :main,
            :alert => "Place not found"
    end
    @donation = Donation.new({:user_id => current_user.id,
      :place_id => @place.id,
      })
  end

  def create
    @donation = Donation.new donation_params
    bottle = Bottle.find_by :code => params[:bottle_code][:code]
    @donation.bottle_id = bottle.andand.id
    @donation.save
    unless @donation.valid?
      render 'new'
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:user_id, :place_id)
  end

end

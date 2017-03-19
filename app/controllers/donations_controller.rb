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
    if @donation.save
      flash[:notice] = "Donation recieved. Thank you!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def donation_params

    required_params = params.require(:donation)
    desired_keys = [:user_id, :place_id, :store]
    attrs = desired_keys.map{|attr| [attr, required_params[attr]] }.to_h  # grab desired attrs
    bottle = Bottle.find_by :code => required_params[:bottle_id]
    attrs[:bottle_id] = bottle.andand.id
    return attrs

  end

end

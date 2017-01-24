class HomeController < ApplicationController
  before_action :authenticate_user!
  skip_load_and_authorize_resource
  def welcome
  end

end

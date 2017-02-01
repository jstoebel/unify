class HomeController < ApplicationController
  skip_load_and_authorize_resource
  def welcome
  end

end

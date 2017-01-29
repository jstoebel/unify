class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    # authorize_resource

    def after_sign_in_path_for(resource)
      '/'
    end

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to "/", :alert => exception.message
    end
end

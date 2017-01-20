class CallbacksController < Devise::OmniauthCallbacksController
    def facebook
        puts "*"*50
        omniauth = request.env["omniauth.auth"]
        puts omniauth
        puts omniauth.info
        puts omniauth.info.email
        puts "*"*50

        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
    end
end

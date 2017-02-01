require 'rails_helper'

RSpec.describe HomeController, type: :controller do


    describe "GET #welcome" do
        before do
            get :welcome
        end
        it "returns http success" do
            expect(response).to have_http_status(:success)
        end

        it "renders index template" do
            expect(response).to render_template(:welcome)
        end
    end

end

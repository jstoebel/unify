require 'rails_helper'

RSpec.describe PlacesController, type: :controller do

    [:reg_user, :admin].each do |role|
        describe "as #{role}" do
            before(:each) do
                @user = FactoryGirl.create role
                login_with @user
            end

            describe "GET #index" do
                before(:each) do
                    get :index
                end
                it "returns http success" do
                    expect(response).to have_http_status(:success)
                end

                it "renders index template" do
                    expect(response).to render_template(:index)
                end
            end

            describe "GET #active" do
                before(:each) do
                    @active_places = FactoryGirl.create_list :place, 5, {:active => true}
                    @inactive_places = FactoryGirl.create_list :place, 5, {:active => false}
                    get :active
                end

                it "returns https succes" do
                    expect(response).to have_http_status(:success)
                end

                it "returns active places" do
                    expect(response.body).to eq(Place.all.where(:active => true).to_json)
                end
            end # inner describe
        end # outer describe
    end # roles loop

    describe "as anonymous user" do
        let(:expect_login_redirect){expect(response).to redirect_to("/users/sign_in")}
        it "denies index" do
            get :index
            expect_login_redirect
        end

        it "denies active" do
            post :active
            expect_login_redirect
        end
    end

end

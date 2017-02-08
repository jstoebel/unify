require 'rails_helper'
RSpec.describe DonationsController, type: :controller do

    describe "as reg_user" do
        before(:each) do
            @user = FactoryGirl.create :reg_user
            login_with @user
        end

        describe "GET new" do
            before(:each) do
                @place = FactoryGirl.create :place
                get :new, :params => {:place => @place.code}
            end

            it "pulls user" do
                expect(@user.attributes).to eq(assigns(:user).attributes)
            end

            it "pulls place" do
                expect(@place.attributes).to eq(assigns(:place).attributes)
            end

            it "sets up a donation" do
                expected_donation = Donation.new({user_id: @user.id,
                    place_id: @place.id
                })
                expect(expected_donation.attributes).to eq(assigns(:donation).attributes)
            end

            it "returns https 200" do
                expect(response).to have_http_status(200)
            end

            it "renders new template" do
                expect(response).to render_template(:new)
            end

        end

        describe "POST create" do
            before(:each) do
                @donation = FactoryGirl.build :donation
            end
            let(:create_donation){post :create, :params => {:donation => {
                                :user_id => @donation.user.id,
                                :place_id => @donation.place.id},
                                :bottle_code => {
                                    :code => code}
                            }}

            context "valid params" do
                let(:code) {@donation.bottle.code}

                it "creates a donation" do
                    # expect(@donation.attributes).to eq(assigns(:donation).attributes)
                    expect{
                        create_donation.to change(Donation, :count).by(1)
                    }
                end

                it "redirects to welcome page" do
                    create_donation
                    expect(response).to redirect_to(root_path)
                end

                it "redirects to welcome page" do
                    create_donation
                    expect(flash[:notice]).to eq("Donation recieved. Thank you!")
                end

            end

            context "invalid params" do
                let(:code) {"bad code"}

                it "doesn't create a donation" do
                    expect{
                        create_donation.to change(Donation, :count).by(0)
                    }
                end

                it "renders new" do
                    create_donation
                    expect(response).to render_template(:new)
                end
            end

        end
    end


    describe "as anonymous user" do
        before do
            @donation = FactoryGirl.build :donation
        end
        let(:expect_login_redirect){expect(response).to redirect_to("/users/sign_in")}

        it "denies new" do
            get :new
            expect_login_redirect
        end

        it "denies create" do
            post :create, @donation.attributes
            expect_login_redirect
        end

    end

end

require 'rails_helper'

RSpec.describe BatchesController, type: :controller do

    describe "as admin" do

        before do
            @user = FactoryGirl.create :admin
            login_with @user
        end

        describe "GET #index" do
            it "assigns all batches as @batches" do
                batches = FactoryGirl.create_list :batch, 5
                get :index
                expect(assigns(:batches).to_a).to eq(batches.to_a)
            end

            it "responds with http success" do
                expect(response).to have_http_status(:ok)
            end
        end

        describe "GET #show" do
            before do
                @batch = FactoryGirl.create :batch
            end

            it "assigns the requested batch as @batch" do
                get :show, params: {:id => @batch.id}
                expect(assigns(:batch)).to eq(@batch)
            end

            it "responds with http success" do
                expect(response).to have_http_status(:ok)
            end

        end # SHOW

        describe "GET #new" do
            it "assigns a new batch as @batch" do
                get :new
                expect(assigns(:batch)).to be_a_new(Batch)
            end

            it "responds with http success" do
                expect(response).to have_http_status(:ok)
            end
        end

        describe "POST #create" do

            let(:create_batch){ post :create, {:params => {:qty => {:n => 1}}} }
            context "with valid params" do
                it "creates a new Batch" do
                    expect{
                        create_batch.to change(Batch, :count).by(1)
                    }
                end

                it "creates n bottles" do
                    expect{
                        create_batch.to change(Bottle, :count).by(1)
                    }
                end

                it "assigns a newly created batch as @batch" do
                    create_batch
                    expect(assigns(:batch)).to be_a(Batch)
                    expect(assigns(:batch)).to be_persisted
                end

                it "redirects to the created batch" do
                    create_batch
                    expect(response).to redirect_to(batch_path(assigns(:batch).id))
                end

            end

        end

        describe "DELETE #destroy" do
            it "destroys the requested batch" do
                batch = FactoryGirl.create :batch
                expect {
                    delete :destroy, params: {id: batch.id}
                }.to change(Batch, :count).by(-1)
            end

            it "destroys the related bottles" do
                batch = FactoryGirl.create :batch
                expect {
                    delete :destroy, params: {id: batch.id}
                }.to change(Bottle, :count).by(-1)
            end

            it "redirects to the batches list" do
                batch = FactoryGirl.create :batch
                delete :destroy, params: {id: batch.to_param}
                expect(response).to redirect_to(batches_url)
            end
        end
    end

    describe "as reg_user" do

        before do
            @user = FactoryGirl.create :reg_user
            login_with @user
            @batch = FactoryGirl.create :batch
        end

        let(:expect_access_denied){expect(response).to redirect_to("/")}
        describe "denies access to everything" do
            it "denies index" do
                get :index
                expect_access_denied
            end

            it "denies show" do
                get :show, params: {id: @batch.id}
                expect_access_denied
            end

            it "denies new" do
                get :new
                expect_access_denied
            end

            it "denies create" do
                get :create, params: {}
                expect_access_denied
            end

            it "denies delete" do
                get :show, params: {id: @batch.id}
                expect_access_denied
            end
        end
    end

    describe "as anonymous user" do
        before do
            @batch = FactoryGirl.create :batch
        end
        let(:expect_login_redirect){expect(response).to redirect_to("/users/sign_in")}
        it "denies index" do
            get :index
            expect_login_redirect
        end

        it "denies show" do
            get :show, params: {id: @batch.id}
            expect_login_redirect
        end

        it "denies new" do
            get :new
            expect_login_redirect
        end

        it "denies create" do
            get :create, params: @batch.attributes
            expect_login_redirect
        end

        it "denies delete" do
            get :show, params: {id: @batch.id}
            expect_login_redirect
        end

    end

end

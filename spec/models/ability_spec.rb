require 'rails_helper'
require "cancan/matchers"
RSpec.describe Ability, type: :model do

    describe "reg_user" do
        before(:each) do
            @user = FactoryGirl.create :reg_user
            @ability = Ability.new(@user)
        end

        describe "donation" do

            [:new, :create].each do |action|
                it "allows #{action}" do
                    expect(@ability.can? action, Donation).to be true
                end
            end
        end

        describe "place" do

            [:index, :active].each do |action|
                it "allows #{action}" do
                    expect(@ability.can? action, Place).to be true
                end
            end
        end

    end
end

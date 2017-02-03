# == Schema Information
#
# Table name: donations
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  place_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bottle_id  :integer          not null
#

require 'rails_helper'

RSpec.describe Donation, type: :model do
    describe "validates presence" do
        before do
            donation = Donation.new
            donation.valid?
            @errors = donation.errors
        end

        [:user, :place, :bottle].each do |attr|
            it "checkes #{attr}_id" do
                expect(@errors["#{attr}_id".to_sym]).to eq(["can't be blank"])
            end
        end

    end # describe

    it "checks bottle uniqueness" do
        bottle = FactoryGirl.create :bottle
        donation1 = FactoryGirl.create :donation, :bottle => bottle
        donation2 = FactoryGirl.build :donation, :bottle => bottle
        expect(donation2.valid?).to be false
        expect(donation2.errors[:bottle_id]).to eq(["has already been used"])
    end

end

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
#  store      :string(255)
#

require 'rails_helper'

RSpec.describe Donation, type: :model do
    describe "validates presence" do
        before do
            donation = Donation.new
            donation.valid?
            @errors = donation.errors
        end

        [:user_id, :place_id, :store].each do |attr|
            it "checks #{attr}" do
                expect(@errors[attr]).to eq(["can't be blank"])
            end
        end

        it "checks bottle code" do
          expect(@errors[:bottle_id]).to eq(["was not provided or could not be found"])
        end

    end # describe

    it "checks bottle uniqueness" do
        bottle = FactoryGirl.create :bottle
        donation1 = FactoryGirl.create :donation, :bottle => bottle
        donation2 = FactoryGirl.build :donation, :bottle => bottle
        expect(donation2.valid?).to be false
        expect(donation2.errors[:bottle_id]).to eq(["has already been used"])
    end

    it "allows multiple donations with forever codes" do
      code = FactoryGirl.create :bottle, {:forever => true}
      donation1 = FactoryGirl.create :donation, :bottle => code
      donation2 = FactoryGirl.build :donation, :bottle => code
      expect(donation2.valid?).to be true

    end

end

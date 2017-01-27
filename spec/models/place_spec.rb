# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  code       :string(255)      not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :boolean
#  active     :boolean
#  blurb      :text(65535)
#

require 'rails_helper'

RSpec.describe Place, type: :model do

    describe "validates presence" do
        before do
            place = Place.new
            place.valid?
            @errors = place.errors
        end

        [:code, :name].each do |attr|
            it "checkes #{attr}" do
                expect(@errors[attr]).to eq(["can't be blank"])
            end
        end

    end # describe

    it "checks bottle uniqueness" do
        place1 = FactoryGirl.create :place
        place2 = FactoryGirl.build :place, :code => place1.code
        expect(place2.valid?).to be false
        expect(place2.errors[:code]).to eq(["has already been taken"])
    end
end

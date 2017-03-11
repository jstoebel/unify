# == Schema Information
#
# Table name: bottles
#
#  id         :integer          not null, primary key
#  code       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  batch_id   :integer          not null
#  forever    :boolean
#

require 'rails_helper'

RSpec.describe Bottle, type: :model do

    describe "validates code" do

        it "requires presence" do
            bottle = Bottle.new
            expect(bottle.valid?).to be false
            expect(bottle.errors[:code]).to eq(["can't be blank"])
        end

        it "requires uniqueness" do
            bottle1 = FactoryGirl.create :bottle
            bottle2 = FactoryGirl.build :bottle, :code => bottle1.code
            expect(bottle2.valid?).to be false
            expect(bottle2.errors[:code]).to eq(["has already been taken"])
        end

    end
end

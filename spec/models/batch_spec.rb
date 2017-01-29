# == Schema Information
#
# Table name: batches
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Batch, type: :model do

    it "creates bottles" do
        batch = Batch.new
        batch.qty = 3
        batch.save!
        expect(batch.bottles.size).to eq(3)
    end

    it "generates a csv" do
        batch = FactoryGirl.create :batch, :bottle_qty => 3
        expected_str = "Bottle Code\n"
        batch.bottles.each {|b| expected_str += b.code + "\n"}
        expect(expected_str).to eq(batch.to_csv)
    end

end

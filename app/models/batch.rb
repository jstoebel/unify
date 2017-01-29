# == Schema Information
#
# Table name: batches
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Batch < ApplicationRecord
    has_many :bottles, :dependent => :destroy
    after_save :create_bottles

    attr_accessor :qty

    def create_bottles
        choices = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
        self.qty.times do |i|
            while true
                bottle_code = 7.times.map{ choices.sample}.join('')
                bottle = Bottle.new({:code => bottle_code,
                    :batch_id => self.id
                })
                break if bottle.valid?
            end
            bottle.save!
        end
    end

    def to_csv(options = {})
        CSV.generate(options) do |csv|
            csv << ["Bottle Code"]
            self.bottles.each do |bottle|
                csv << [bottle.code]
            end
        end # generate
    end

end

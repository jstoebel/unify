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

class Donation < ApplicationRecord
    belongs_to :place
    belongs_to :user
    belongs_to :bottle

    validates :user_id, presence: true
    validates :place_id, presence: true
    validates :store, presence: true

    validates :bottle_id,
        presence: true,
        :uniqueness => {
          :message => "has already been used",
          :if => :bottle_not_forever
        }

    def bottle_not_forever
      return !self.bottle.andand.forever
    end

end

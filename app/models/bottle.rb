# == Schema Information
#
# Table name: bottles
#
#  id         :integer          not null, primary key
#  code       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  batch_id   :integer
#  forever    :boolean
#

class Bottle < ApplicationRecord
    has_one :donation
    belongs_to :batch

    validates :code, presence: true, uniqueness: true

    def repr
        return self.code
    end
end

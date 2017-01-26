# == Schema Information
#
# Table name: bottles
#
#  id         :integer          not null, primary key
#  code       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bottle < ApplicationRecord
    has_one :donation

    validates :code, presence: true, uniqueness: true
end

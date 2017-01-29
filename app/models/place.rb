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

class Place < ApplicationRecord

  has_many :donations

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true

  def repr
      return self.code
  end
end

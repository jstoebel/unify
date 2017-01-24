class Place < ApplicationRecord

  has_many :donations

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
end

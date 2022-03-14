class Reservation < ApplicationRecord
  include ActiveModel::Serialization
  belongs_to :guest

  validates :reservation_code, presence: true, uniqueness: true
end

class Guest < ApplicationRecord
  include ActiveModel::Serialization

  has_many :reservations

  validates :email, presence: true, uniqueness: true
  validates :phone, uniqueness: true
end

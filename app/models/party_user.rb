class PartyUser < ApplicationRecord
  validates :user_id, :party_id, presence: true

  belongs_to :user
  belongs_to :party
end

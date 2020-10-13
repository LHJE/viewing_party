class Party < ApplicationRecord
  # alias_method :host, :user_id
  # belongs_to :host, class_name: 'User'
  belongs_to :user
  has_many :party_users
  has_many :users, through: :party_users

  validates :movie_title,
            :user_id,
            :date,
            :time, presence: true

  def user_status(user_id)
    if self.user_id == user_id
      'Host'
    else
      'Invited'
    end
  end
end

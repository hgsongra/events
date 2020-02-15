class Meeting < ApplicationRecord

  paginates_per 10

  validates :title, :description, :start_at, :end_at, presence: true
  has_many :invites
  has_many :users, through: :invites

  def current_user_going?(loggedin_user)
    self.invites.exists?(user: loggedin_user)
  end

  def past?
    self.start_at < Time.now
  end
end

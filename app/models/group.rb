class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  def self.owned_group(user)
  	self.where(owner_id: user.id)
  end
end

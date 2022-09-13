class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :members, through: :memberships, source: :user
  has_many :memberships
end

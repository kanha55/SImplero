class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :owned_group, foreign_key: "owner_id", class_name: "Group"
  has_many :memberships
  has_many :groups, through: :memberships

  def is_join?(group)
    membership = Membership.where(user_id: self.id, group_id: group.id)
    membership.present?
  end

  def owner_group?(group) 
    self.id == group.owner_id
  end
end

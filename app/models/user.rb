class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :owned_group, foreign_key: "owner_id", class_name: "Group"
  has_many :memberships
  has_many :groups, through: :memberships
end

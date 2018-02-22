class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets
  has_many :likes
  has_many :active_relationships, foreign_key: "follower_id", class_name: "Relationship"
  has_many :passive_relationships, foreign_key: "following_id", class_name: "Relationship"

  has_many :followings, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower


  mount_uploader :img, PhotoUploader

  validates :handlename, presence: :true, uniqueness: { case_sensitive: false }


end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets

  mount_uploader :img, PhotoUploader

  validates :handlename, presence: :true, uniqueness: { case_sensitive: false }


end

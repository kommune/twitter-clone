class Tweet < ApplicationRecord

  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :tweet, :presence => true, :length => { 
  :maximum => 140,
  :too_long  => "Please limit your tweet to 140 characters."
}

  mount_uploader :image, PhotoUploader

end

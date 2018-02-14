class Tweet < ApplicationRecord

  belongs_to :user

  validates_presence_of :tweet

  mount_uploader :image, PhotoUploader

end

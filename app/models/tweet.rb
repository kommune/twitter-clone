class Tweet < ApplicationRecord

  belongs_to :user

  validates_presence_of :tweet
#   validates :tweet, :presence => true, :length => { 
#   :maximum => 140,
#   :tokenizer => lambda { |str| str.scan(/\w+/) },
#   :too_long  => "Please limit your tweet to 140 words."
# }

  mount_uploader :image, PhotoUploader

end

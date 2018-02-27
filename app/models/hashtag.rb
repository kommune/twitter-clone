class Hashtag < ApplicationRecord

  validates :hashtag, presence: true, uniqueness: {case_sensitive: false}
  has_many :hashtagstweets, dependent: :destroy
  has_many :tweets, through: :hashtagstweets

end
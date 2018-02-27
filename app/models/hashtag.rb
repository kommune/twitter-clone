class Hashtag < ApplicationRecord

  validates :hashtag, presence: true, uniqueness: {case_sensitive: false}
  has_many :hashtagstweets
  has_many :tweets, through: :hashtagstweets

end
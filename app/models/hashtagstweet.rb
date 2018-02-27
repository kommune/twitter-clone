class Hashtagstweet < ApplicationRecord

  belongs_to :tweet
  belongs_to :hashtag

end
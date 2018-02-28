require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it { is_expected.to validate_presence_of(:tweet) }
  
  it do
    user = User.new(
      name: 'blah',
      handlename: 'blah',
      email: 'blah@gmail.com',
      encrypted_password: '123456'
    )
    tweet = user.tweets.new(
      tweet: 'HELLO LALALA'
    )
    expect(tweet).to validate_length_of(:tweet).
      is_at_most(140).with_long_message("Please limit your tweet to 140 characters.")
  end

  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:replies).dependent(:destroy) }
  it { is_expected.to have_many(:hashtagstweets).dependent(:destroy) }
  it { is_expected.to have_many(:hashtags).through(:hashtagstweets) }

end
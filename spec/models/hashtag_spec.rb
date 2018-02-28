require 'rails_helper'

RSpec.describe Hashtag, type: :model do
  it { is_expected.to validate_presence_of(:hashtag) }
  
  it 'should be valid when hashtag is unique and case insensitive' do
    hashtag = Hashtag.new(
      hashtag: '#hElLo'
    )
    expect(hashtag).to validate_uniqueness_of(:hashtag).case_insensitive
  end

end
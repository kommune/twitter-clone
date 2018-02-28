require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:handlename) }
  
  it 'should be valid when handlename is unique and case insensitive' do
    user = User.new(
      name: 'blah',
      handlename: 'blah',
      email: 'blah@gmail.com',
      encrypted_password: '123456'
    )
    expect(user).to validate_uniqueness_of(:handlename).case_insensitive
  end

  it { is_expected.to have_many(:tweets).dependent(:destroy) }
  it { is_expected.to have_many(:replies).dependent(:destroy) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:active_relationships).with_foreign_key("follower_id").class_name("Relationship") }
  it { is_expected.to have_many(:passive_relationships).with_foreign_key("following_id").class_name("Relationship") }
  it { is_expected.to have_many(:followings).through(:active_relationships).source(:following) }
  it { is_expected.to have_many(:followers).through(:passive_relationships).source(:follower) }

end
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

end
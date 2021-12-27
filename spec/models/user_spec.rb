require 'rails_helper'
require 'spec_helper'
# Do model specs test for the Users model
RSpec.describe User, type: :model do
  
  it 'valid the presence of email' do
    user = User.new(email: nil, first_name: 'John', last_name: 'Doe', avatar: 'http://example.com/avatar.png')
    expect(user).to_not be_valid
  end
  it 'valid the presence of first_name' do
    user = User.new(email: 'test@email.com', first_name: nil, last_name: 'Doe', avatar: 'http://example.com/avatar.png')
    expect(user).to_not be_valid
  end
  it 'valid the presence of last_name' do
    user = User.new(email: 'test@email.com', first_name: 'John', last_name: nil, avatar: 'http://example.com/avatar.png')
    expect(user).to_not be_valid
  end
end

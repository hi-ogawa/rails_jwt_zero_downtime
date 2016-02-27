require 'rails_helper'

describe User do

  let(:user){ FactoryGirl.create(:user) }

  describe "#generate_token and self.find_from_token" do
    it "." do
      token = user.generate_token
      user_from_token = User.find_from_token(token)
      expect(user_from_token.persisted?).to eq(true)
    end
  end
end

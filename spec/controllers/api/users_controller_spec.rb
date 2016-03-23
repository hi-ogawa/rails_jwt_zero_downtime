require 'rails_helper'

describe Api::UsersController, type: :controller do

  let(:user){FactoryGirl.create(:user)}

  describe "get :me" do
    describe "when logged in" do
      before(:each) { mock_login(user) }
      it "." do
        resp = get :me
        expect(resp.status).to eq(200)
      end
    end

    describe "when not logged in" do
      it "." do
        user
        resp = get :me
        expect(resp.status).to eq(401)
      end
    end
  end

  describe "post :create" do
    it "." do
      resp = get :create, {user: FactoryGirl.attributes_for(:user)}
      expect(resp.status).to eq(200)
    end
  end
end

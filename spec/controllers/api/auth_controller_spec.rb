require 'rails_helper'

describe Api::AuthController, type: :controller do

  let(:user) {FactoryGirl.create(:user)}

  describe "post :login" do
    describe "success case" do
      it "." do
        resp = post :login, auth: {email: user.email, password: user.password}
        json_resp = JSON.parse(resp.body)
        expect(json_resp["name"]).to eq(user.name)
        expect(json_resp["email"]).to eq(user.email)
        expect(json_resp["token"]).not_to eq(nil)
        expect(resp.status).to eq(200)
      end
    end

    describe "fail case" do
      it "." do
        resp = post :login, auth: {email: user.email, password: user.password + "xxx"}
        expect(resp.status).to eq(401)
      end
    end
  end
end

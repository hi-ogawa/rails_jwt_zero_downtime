require 'rails_helper'

describe Api::StatusController, type: :controller do

  describe "get :show" do
    it "." do
      resp = get :show
      expect(JSON.parse(resp.body)).to eq({"status" => 'ok'})
      expect(resp.status).to eq(200)
    end
  end
end

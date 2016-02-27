Rails.application.routes.draw do
  namespace "api" do

    get "status" => "status#show"



end

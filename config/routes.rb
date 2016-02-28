Rails.application.routes.draw do
  namespace "api" do

    get "status" => "status#show"

    get "users/me" => "users#me"
    post "users" => "users#create"

    post "auth/login" => "auth#login"

    match "*path" => "base#route_not_found", via: :all
  end
end

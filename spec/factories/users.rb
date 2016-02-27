FactoryGirl.define do
  factory :user do
    name "hiogawa"
    sequence(:email){|n| "test#{n}.abc@def.com"}
    password "asdfjkl;"
  end
end

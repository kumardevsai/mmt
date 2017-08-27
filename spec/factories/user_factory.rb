# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "member_#{n}@example.com" }
    password "password"

    trait :admin do
      admin true
    end
  end
end

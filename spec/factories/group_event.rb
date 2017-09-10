FactoryGirl.define do
  factory :group_event do
    name 'Example draft event'
    start_date '10-10-2017'
    status :draft
  end

  trait :invalid_published do
    status :published
  end

  trait :valid_published do
    status :published
    description 'The best event in the world!'
    location 'Colombia'
    end_date '20-10-2017'
  end
end

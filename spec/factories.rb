FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password  {'blahblah'}
    role {'developer'}

    trait :admin do
      email {"#{Faker::Name.first_name }@admin.io"}
      role {'admin'}
    end
  end

  factory :project do
    title {Faker::Quote.robin}
  end

  factory :todo do
    association :project, factory: :project
    association :developer, factory: :user
    description {Faker::Quote.yoda}
    status {'assigned'}

    trait :in_progress do
      status {'in_progress'}
    end

    trait :done do
      status {'done'}
    end    
  end
end
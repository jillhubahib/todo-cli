FactoryBot.define do
  factory :task, class: ::Todo::Task do
    name { Faker::Verb.base }
  end
end

FactoryGirl.define do
  factory :subject, class: Questionable::Subject do
    sequence(:slug) { |num| "subject-#{num}" }
    sequence(:subject) { |num| "Subject #{num}" }
  end
end

FactoryGirl.define do
  factory :answer, class: Questionable::Answer do
    user nil
    question nil
    option nil
    message 'The Answer'
  end
end

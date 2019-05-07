
FactoryGirl.define do
  factory :question, class: Questionable::Question do
    title "What's your favorite color?"
    note  'Please choose your favorite color'
    input_type Questionable::Question::InputTypes::STRING
  end
end


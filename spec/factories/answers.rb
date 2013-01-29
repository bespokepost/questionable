
FactoryGirl.define do
  factory :answer, :class => Questionable::Answer do
    user nil
    assignment nil
    option nil
    message 'The Answer'
  end
end


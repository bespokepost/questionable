
FactoryGirl.define do
  factory :assignment, :class => Questionable::Assignment do
    question
    subject_type 'preference'
    subject_id nil
    position { rand(9) }
  end
end


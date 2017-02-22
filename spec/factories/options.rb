
FactoryGirl.define do
  factory :option, class: Questionable::Option do
    title 'Blue'
    note  'As the sky'
    position { rand(9) }
  end
end


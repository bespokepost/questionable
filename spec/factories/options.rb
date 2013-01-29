
FactoryGirl.define do
  factory :option, :class => Questionable::Option do
    #question nil
    title 'Blue'
    note  'As the sky'
    position { rand(9) }
  end
end


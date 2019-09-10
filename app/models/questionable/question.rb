module Questionable
  class Question < ApplicationRecord
    has_many :options
    has_many :assignments
    has_many :subjects, through: :assignments
    has_many :answers, inverse_of: :question

    validates :title, presence: true

    # :reek:TooManyConstants
    module InputTypes
      CHECKBOXES = 'checkboxes'.freeze
      DATE = 'date'.freeze
      MULTISELECT = 'multiselect'.freeze
      RADIO = 'radio'.freeze
      SELECT = 'select'.freeze
      STRING = 'string'.freeze

      ALL = [CHECKBOXES, MULTISELECT, RADIO, STRING, SELECT, DATE].freeze
    end

    scope :with_subject, ->(subject) { joins(:assignments).merge(Questionable::Assignment.with_subject(subject)) }

    def accepts_multiple_answers?
      [InputTypes::CHECKBOXES, InputTypes::MULTISELECT].include?(input_type)
    end

    InputTypes::ALL.each do |type|
      class_eval <<-EOV, __FILE__, __LINE__
        def #{type}?
          input_type == "#{type}"
        end
      EOV
    end

    def answers_for_user(user)
      answers.where(user: user)
    end
  end
end

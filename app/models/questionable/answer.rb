module Questionable
  class Answer < ApplicationRecord
    belongs_to :user
    belongs_to :assignment
    belongs_to :option
    has_one :question, through: :assignment

    def date_answer
      message.try(:to_date)
    rescue ArgumentError
    end

    def answer_summary
      if option && message
        "#{option.title} (#{message})"
      elsif message && question.date?
        date_answer
      elsif option
        option.title
      else
        message
      end
    end
  end
end

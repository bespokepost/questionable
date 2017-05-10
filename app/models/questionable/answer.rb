module Questionable
  class Answer < ActiveRecord::Base
    belongs_to :user
    belongs_to :option
    belongs_to :parent_question, class_name: 'Questionable::Question', foreign_key: 'question_id'
    belongs_to :assignment
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

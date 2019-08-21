module Questionable
  class Answer < ApplicationRecord
    belongs_to :user
    belongs_to :option
    belongs_to :parent_question, class_name: 'Questionable::Question', foreign_key: 'question_id',
               inverse_of: :child_answers
    belongs_to :assignment

    # TODO: remove `through: :assignment` and `:parent_question` after transition
    # https://github.com/bespokepost/questionable/pull/19#discussion_r115736332
    has_one :question, through: :assignment

    before_save do
      self.question_id ||= assignment.try(:question_id)
    end

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

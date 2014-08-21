module Questionable
  class Answer < ActiveRecord::Base
    belongs_to :user
    belongs_to :assignment
    belongs_to :option
    has_one :question, through: :assignment

    def date_answer
      return nil if message.nil?

      self.message.to_date
    rescue ArgumentError
      nil
    end

    def answer_summary
      if self.option && self.message
        "#{self.option.title} (#{self.message})"
      elsif self.message && self.question.date_question?
        self.date_answer
      elsif self.option
        self.option.title
      else
        self.message
      end
    end


  end
end

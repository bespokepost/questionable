module Questionable
  class Answer < ActiveRecord::Base
    attr_accessible :user_id, :assignment_id, :option_id, :message

    belongs_to :user
    belongs_to :assignment
    belongs_to :option
    has_one :question, :through => :assignment

    def date_answer
      return nil if message.nil?

      self.message.to_date
    rescue ArgumentError
      nil
    end
  end
end

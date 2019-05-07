module Questionable
  class Assignment < ApplicationRecord
    belongs_to :question
    belongs_to :subject, polymorphic: true

    has_many :answers
    has_many :answered_options, through: :answers, source: :option

    def self.with_subject(subject)
      if subject.is_a?(Symbol) || subject.is_a?(String)
        assignments = Questionable::Assignment.where(subject_type: subject)
      else
        assignments = Questionable::Assignment.where(
          subject_type: subject.class.to_s,
          subject_id: subject.id)
      end

      assignments.order(:position)
    end

    def answers_for_user(user)
      answers.where(user_id: user.id)
    end
  end
end

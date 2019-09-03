module Questionable
  class Assignment < ApplicationRecord
    belongs_to :question
    belongs_to :subject, polymorphic: true

    has_many :answers, through: :question
    has_many :answered_options, through: :answers, source: :option

    delegate :answers_for_user, to: :question

    scope :with_subject, ->(subject) {
      condition = subject.is_a?(Symbol) || subject.is_a?(String) ? { subject_type: subject } : { subject: subject }
      where(condition).order(:position)
    }
  end
end

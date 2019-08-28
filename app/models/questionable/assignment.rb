module Questionable
  class Assignment < ApplicationRecord
    belongs_to :question, inverse_of: :assignments
    belongs_to :subject, polymorphic: true

    has_many :answers, through: :question
    has_many :answered_options, through: :answers, source: :option

    belongs_to :parent_assignment, class_name: 'Questionable::Assignment', foreign_key: 'parent_id',
               inverse_of: :child_assignments
    has_many :child_assignments, class_name: 'Questionable::Assignment', foreign_key: 'parent_id',
             inverse_of: :parent_assignment, dependent: :nullify

    delegate :answers_for_user, to: :question

    scope :with_subject, ->(subject) {
      condition = subject.is_a?(Symbol) || subject.is_a?(String) ? { subject_type: subject } : { subject: subject }
      where(condition).order(:position)
    }
  end
end

module Questionable
  class Question < ApplicationRecord
    has_many :options
    has_many :assignments
    has_many :subjects, through: :assignments
    has_many :answers, through: :assignments

    validates :title, presence: true

    def accepts_multiple_answers?
      %w(checkboxes multiselect).include?(input_type)
    end

    %w(checkboxes multiselect radio string select date).each do |type|
      class_eval <<-EOV, __FILE__, __LINE__
        def #{type}?
          input_type == "#{type}"
        end
      EOV
    end

    def answers_for_user(user)
      existing_answers_for_user = answers.where(user_id: user.id)
      if existing_answers_for_user.any?
        existing_answers_for_user.to_a
      else
        [answers.build(user_id: user.id)]
      end
    end

    def self.with_subject(subject)
      assignments =
        if subject.is_a?(Symbol) || subject.is_a?(String)
          { subject_type: subject }
        else
          { subject_type: subject.class.to_s, subject_id: subject.id }
        end

      join_query = 'INNER JOIN questionable_assignments ' \
                   'ON questionable_assignments.question_id = questionable_questions.id'

      Questionable::Question.joins(join_query).
        where(questionable_assignments: assignments).
        order('questionable_assignments.position')
    end
  end
end

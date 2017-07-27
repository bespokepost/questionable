module Questionable
  class Question < ApplicationRecord
    has_many :options
    has_many :assignments
    has_many :subjects, through: :assignments
    has_many :answers, through: :assignments

    validates_presence_of :title

    def accepts_multiple_answers?
      ['checkboxes', 'multiselect'].include?(self.input_type)
    end

    %w(checkboxes multiselect radio string select date).each do |type|
      class_eval <<-EOV, __FILE__, __LINE__
        def #{type}?
          input_type == "#{type}"
        end
      EOV
    end

    def answers_for_user(user)
      answers = self.answers.where(user_id: user.id)
      answers.any? ? answers : [self.answers.build(user_id: user.id)]
    end

    def self.with_subject(subject)
      if subject.kind_of?(Symbol) or subject.kind_of?(String)
        assignments = { subject_type: subject }
      else
        assignments = { subject_type: subject.class.to_s, subject_id: subject.id }
      end

      join_query = 'INNER JOIN questionable_assignments '
      join_query += 'ON questionable_assignments.question_id = questionable_questions.id'

      query = Questionable::Question.joins(join_query)
      query = query.where(questionable_assignments: assignments)
      query = query.order('questionable_assignments.position')
      query
    end
  end
end

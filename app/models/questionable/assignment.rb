module Questionable
  class Assignment < ActiveRecord::Base
    attr_accessible :question_id, :subject_id, :subject_type, :position

    belongs_to :question
    belongs_to :subject, :polymorphic => true

    has_many :answers
    has_many :answered_options, :through => :answers, :source => :option

    def self.with_subject(user, subject)
      if subject.kind_of?(Symbol) or subject.kind_of?(String)
        assignments = Questionable::Assignment.where(:subject_type => subject)
      else
        assignments = Questionable::Assignment.where(:subject => subject)
      end

      assignments.order(:position)
    end

    def answers_for_user(user)
      if self.answers.where(user_id: user.id).any?
        self.answers.where(user_id: user.id)
      else
        if self.question.accepts_multiple_answers?
          self.question.options.map { |o| Answer.new(assignment_id: self.id, option_id: o.id, user_id: user.id) }
        else
          [ self.answers.build(user_id: user.id) ]
        end
      end
    end

    # for ActiveAdmin
    def display_name
      "#{self.subject_type}#{self.subject_id}: #{self.question.title}"
    end

  end # End Assignment
end

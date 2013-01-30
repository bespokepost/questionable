module Questionable
  class Question < ActiveRecord::Base
    has_many :options, :order => 'questionable_options.position ASC'
    has_many :assignments
    has_many :subjects, :through => :assignments
    has_many :answers, :through => :assignments

    attr_accessible :title, :input_type, :note, :category

    validates_presence_of :title

    def accepts_multiple_answers?
      ['checkboxes', 'multiselect'].include?(self.input_type)
    end

    def answers_for_user(user)
      answers = self.answers.where(user_id: user.id)
      answers.any? ? answers : [self.answers.build(user_id: user.id)]
    end

    def self.with_subject(subject)
      Questionable::Question.joins('INNER JOIN questionable_assignments ON questionable_assignments.question_id = questionable_questions.id').where(:questionable_assignments => { :subject => subject }).order('questionable_assignments.position')
    end

    def self.with_subject_type(type)
      Questionable::Question.joins('INNER JOIN questionable_assignments ON questionable_assignments.question_id = questionable_questions.id').where(:questionable_assignments => { :subject_type => type }).order('questionable_assignments.position')
    end
  end
end

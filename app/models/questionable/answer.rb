module Questionable
  class Answer < ActiveRecord::Base
    attr_accessible :user_id, :assignment_id, :option_id, :message

    belongs_to :user
    belongs_to :assignment
    belongs_to :option
    has_one :question, :through => :assignment

=begin
    def self.build_answers_for_subject(user, subject)
      if subject.kind_of?(Symbol) or subject.kind_of?(String)
        assignments = Questionable::Assignment.where(:subject_type => subject)
      else
        assignments = Questionable::Assignment.where(:subject => subject)
      end

      assignments = assignments.order(:position)
      assignments.map { |as| as.answers_for_user(user) }
    end
=end

    #  Questionable::Question.joins('INNER JOIN questionable_assignments ON questionable_assignments.question_id = questionable_questions.id').where(:questionable_assignments => { :subject_type => type }).order('questionable_assignments.position')

  end
end

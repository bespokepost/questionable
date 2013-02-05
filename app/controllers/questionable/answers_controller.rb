require_dependency "questionable/application_controller"

module Questionable
  class AnswersController < ApplicationController
    def create
      answers = params[:answers] 

      if answers.is_a?(Hash)
        # Answers should always be a hash, and the values should be arrays, 
        # even if the question input_type only supports a single answer.

        answers.each do |assignment_id, answers|
          assignment = Assignment.find(assignment_id)
          assignment.answers.where(user_id: current_user.id).delete_all

          if assignment.question.input_type == 'string'
            message = answers.first || ''
            assignment.answers.create(user_id: current_user.id, message: message[0..255])
          elsif assignment.question.input_type == 'date'
            date = answers.first
            if date[:year].present? or date[:month].present? or date[:day].present?
              if date[:year].present? and date[:month].present? and date[:day].present?
                answer = assignment.answers.build(user_id: current_user.id, message: "#{date[:year]}-#{date[:month]}-#{date[:day]}")
                if answer.date_answer.nil?
                  flash[:warn] = 'Could not save date. Invalid date.'
                else
                  answer.save
                end
              else
                flash[:warn] = 'Could not save date. You did not select all three fields.'
              end
            end
          else
            option_ids = answers
            option_ids.each do |oid|
              unless oid.blank?
                assignment.answers.create(user_id: current_user.id, option_id: oid)
              end
            end
          end

        end
      end
  
      redirect_to :back
    end
  end
end

require_dependency "questionable/application_controller"

module Questionable
  class AnswersController < ApplicationController
    respond_to :html, :js

    def create
      assignment = Assignment.find(params[:assignment_id])

      a = Answer.new
      a.assign_attributes({
        assignment: assignment,
        user: current_user, 
        option_id: params[:answer][:option_id],
        message:   params[:answer][:message]
      }, without_protection: true)

      if a.save
        respond_to do |format|
          format.html { redirect_to :back }
          format.js   { render :text => 'Ok' }
        end
      else
        respond_to do |format|
          format.html do 
            flash[:info] = 'Error saving Answer'
            redirect_to :back
          end 
          format.js { render :text => 'Error' }
        end
      end
    end

    def create_multiple
      answers = params[:answers] 

      if answers.is_a?(Hash)
        # Answers should always be a hash, and the values should be arrays, 
        # even if the question input_type only supports a single answer.

        answers.each do |assignment_id, answers|
          assignment = Assignment.find(assignment_id)
          assignment.answers.where(user_id: current_user.id).delete_all

          if assignment.question.input_type == 'string'
            message = answers.first
            assignment.answers.create(user_id: current_user.id, message: message)
          elsif assignment.question.input_type == 'date'
            date = answers.first
            if date[:year].present? or date[:month].present? or date[:day].present?
              if date[:year].present? and date[:month].present? and date[:day].present?
                assignment.answers.create(user_id: current_user.id, message: "#{date[:year]}-#{date[:month]}-#{date[:day]}")
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

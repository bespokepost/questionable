require_dependency "questionable/application_controller"

module Questionable
  class AnswersController < ApplicationController
    def create
      answers = params[:answers]

      return render_error unless current_user && answers.present?

      # Answers should always be a hash, and the values should be arrays,
      # even if the question input_type only supports a single answer.
      answers.each do |assignment_id, assignment_answers|
        assignment = Assignment.find(assignment_id)
        question = assignment.question
        question_answers = question.answers
        question_answers.where(user_id: current_user.id).delete_all

        if question.string?
          message = assignment_answers.first || ''
          question_answers.create(user_id: current_user.id, message: message[0..255])
        elsif question.date?
          date_answer = Questionable::DateAnswer.new(assignment_answers.first)
          next if date_answer.empty?

          if date_answer.valid?
            answer = question_answers.build(user_id: current_user.id, message: date_answer.to_s)

            unless answer.save
              flash[:warn] = 'Could not save date. Invalid date.'
            end
          else
            flash[:warn] = 'Could not save date. You did not select all three fields or you entered an invalid date.'
          end
        else
          assignment_answers.reject(&:blank?).each do |oid|
            question_answers.create(user_id: current_user.id, option_id: oid)
          end
        end
      end

      respond_to do |format|
        format.html { redirect_to_back }
        format.json { render json: { message: flash[:warn] }, status: :ok }
      end
    end

    private

    def render_error
      flash[:warn] = 'Something went wrong, please try again'

      respond_to do |format|
        format.html { redirect_to_back }
        format.json { render json: { error: flash[:warn] }, status: :unprocessable_entity }
      end
    end

    def redirect_to_back
      redirect_back(fallback_location: main_app.root_url)
    end
  end
end

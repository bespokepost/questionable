namespace :questionable do
  def error_message(answer)
    puts "Answer #{answer.id} could not be updated"
  end

  desc 'Fills in all question_id columns on answers'
  task update_answers_question_id: :environment do
    updated = 0
    count = Questionable::Answer.count
    
    Questionable::Answer.find_in_batches(batch_size: 100) do |answers|
      answers.each do |answer|
        question = answer.question

        if question
          if answer.update_column(:question_id, question.id)
            updated += 1
          else
            error_message(answer)
          end
        else
          error_message(answer)
        end
      end
    end

    puts "Records updated: #{updated}/#{count}"
    puts "Errors: #{count - updated}"
  end
end

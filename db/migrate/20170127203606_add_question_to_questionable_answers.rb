class AddQuestionToQuestionableAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :questionable_answers, :question_id, :integer
    add_index :questionable_answers, :question_id
  end
end

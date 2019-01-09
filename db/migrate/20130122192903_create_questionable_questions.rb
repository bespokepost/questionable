class CreateQuestionableQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questionable_questions do |t|
      t.string :category
      t.string :title
      t.string :note
      t.string :input_type # string, select, radio, checkboxes, multiselect, etc.  statement (checkbox)

      t.timestamps
    end
  end
end

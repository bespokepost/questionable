class CreateQuestionableAnswers < ActiveRecord::Migration
  def change
    create_table :questionable_answers do |t|
      t.integer :user_id
      t.integer :assignment_id
      t.integer :option_id  # which option was chosen as the answer
      t.string  :message    # a freeform message e.g. "Other"

      t.timestamps
    end

    add_index :questionable_answers, :user_id
    add_index :questionable_answers, :assignment_id
    add_index :questionable_answers, :option_id
  end
end

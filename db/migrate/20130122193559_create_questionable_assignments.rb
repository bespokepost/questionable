class CreateQuestionableAssignments < ActiveRecord::Migration
  def change
    create_table :questionable_assignments do |t|
      t.integer :question_id
      t.integer :subject_id
      t.string  :subject_type
      t.integer :position

      t.timestamps
    end

    add_index :questionable_assignments, [:subject_type, :subject_id, :position], :name => 'index_questionable_assignments_on_subject_and_position' 
  end
end

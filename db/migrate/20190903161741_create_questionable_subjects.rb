class CreateQuestionableSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :questionable_subjects do |t|
      t.string :slug, null: false
      t.string :title, null: false
      t.timestamps
    end

    add_index :questionable_subjects, :slug, unique: true
  end
end

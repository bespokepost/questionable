class CreateQuestionableOptions < ActiveRecord::Migration
  def change
    create_table :questionable_options do |t|
      t.integer :question_id
      t.string  :title
      t.string  :note
      t.integer :position

      t.timestamps
    end
    
    add_index :questionable_options, [:question_id, :position]
  end
end

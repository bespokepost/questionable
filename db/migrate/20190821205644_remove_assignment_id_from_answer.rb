class RemoveAssignmentIdFromAnswer < ActiveRecord::Migration[5.0]
  def up
    remove_index :questionable_answers, :assignment_id
    remove_column :questionable_answers, :assignment_id, :integer
  end

  def down
    add_column :questionable_answers, :assignment_id, :integer
    add_index :questionable_answers, :assignment_id
  end
end

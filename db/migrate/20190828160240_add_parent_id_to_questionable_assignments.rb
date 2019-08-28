class AddParentIdToQuestionableAssignments < ActiveRecord::Migration[5.0]
  def change
    add_column :questionable_assignments, :parent_id, :integer
    add_index :questionable_assignments, :parent_id
  end
end

class AddScoreToQuestionableOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :questionable_options, :score, :integer
  end
end

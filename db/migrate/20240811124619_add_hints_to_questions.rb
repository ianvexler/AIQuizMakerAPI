class AddHintsToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :hints, :text
  end
end

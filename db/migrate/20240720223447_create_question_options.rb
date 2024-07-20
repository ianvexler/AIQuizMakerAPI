class CreateQuestionOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :question_options do |t|
      t.references :question, foreign_key: true, null: false
      t.string :value, null: false
      t.boolean :is_correct, default: false, null: false

      t.timestamps
    end
  end
end

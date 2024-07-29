class CreateQuizQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_questions do |t|
      t.references :quiz, foreign_key: true, null: false
      t.references :question, foreign_key: true, null: false

      t.timestamps
    end
  end
end

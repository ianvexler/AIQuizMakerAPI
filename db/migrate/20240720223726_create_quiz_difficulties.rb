class CreateQuizDifficulties < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_difficulties do |t|
      t.references :quiz, foreign_key: true, null: false
      t.references :difficulty, foreign_key: true, null: false
      
      t.timestamps
    end
  end
end

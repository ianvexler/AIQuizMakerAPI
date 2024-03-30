# frozen_string_literal: true

class CreateQuiz < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.string :title, null: false
      t.string :goal
      t.string :instructions
      t.json :quiz_data, null: false
      
      t.timestamps
    end
  end
end

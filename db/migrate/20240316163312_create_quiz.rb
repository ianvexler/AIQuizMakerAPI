# frozen_string_literal: true

class CreateQuiz < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.string :type, null: false
      t.integer :length, default: 10
      t.string :difficulty, null: false
      
      t.timestamps
    end
  end
end

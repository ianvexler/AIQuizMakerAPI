# frozen_string_literal: true

class CreateQuiz < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.string :quiz_type, null: false
      t.integer :length, default: 10
      
      t.timestamps
    end
  end
end

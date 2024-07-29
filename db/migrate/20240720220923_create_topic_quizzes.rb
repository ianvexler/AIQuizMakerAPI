class CreateTopicQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :topic_quizzes do |t|
      t.references :topic, foreign_key: true, null: false
      t.references :quiz, foreign_key: true, null: false
      
      t.timestamps
    end
  end
end

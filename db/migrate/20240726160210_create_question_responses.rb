class CreateQuestionResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :question_responses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :question_option, null: false, foreign_key: true
      t.integer :duration
      t.float :rating

      t.timestamps
    end
  end
end

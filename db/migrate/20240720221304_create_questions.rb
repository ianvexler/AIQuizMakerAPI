class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :content, null: false
      t.integer :confidence, default: 0
      t.references :difficulty, foreign_key: true, null: false
      t.boolean :flagged, null: false, default: false
      t.boolean :archived, null: false, default: false

      t.timestamps
    end
  end
end

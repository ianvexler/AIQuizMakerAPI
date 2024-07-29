class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.text :description
      t.integer :order
      t.references :course, foreign_key: true
      t.boolean :archived
      t.index [:name, :course_id], unique: true
      t.index [:order, :course_id], unique: true
      
      t.timestamps
    end
  end
end

class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.string :description
      t.integer :order
      t.references :course, foreign_key: true
      t.boolean :archived
      
      t.timestamps
    end
  end
end

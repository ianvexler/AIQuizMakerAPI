class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :description
      t.string :overview
      t.boolean :private
      t.boolean :archived

      t.timestamps
    end
  end
end

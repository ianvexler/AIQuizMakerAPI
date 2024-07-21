class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :description
      t.string :overview
      t.boolean :is_private, default: true
      t.boolean :archived, default: false
      r.references :course_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end

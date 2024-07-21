class CreateCourseGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :course_groups do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.index [:name, :organization_id], unique: true
      t.boolean :archived, default: false

      t.timestamps
    end
  end
end

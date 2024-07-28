class CreateEnrolments < ActiveRecord::Migration[7.1]
  def change
    create_table :enrolments do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.boolean :active

      t.timestamps
    end
  end
end

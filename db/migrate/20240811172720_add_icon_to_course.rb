class AddIconToCourse < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :icon, :string
  end
end

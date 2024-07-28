class AddUserRelationships < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :organization, foreign_key: true
    add_reference :questions, :flagged_by, foreign_key: { to_table: :users }
  end
end

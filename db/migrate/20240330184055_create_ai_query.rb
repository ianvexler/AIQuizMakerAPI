class CreateAiQuery < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_queries do |t|
      t.string :text, null: false
      t.json :json_format, null: false
      t.boolean :active, default: false
      t.boolean :draft, default: true
      t.integer :version, default: false
      t.references :ai_query_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end

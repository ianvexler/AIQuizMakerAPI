class CreateAiQueryTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_query_types do |t|
      t.string :name, null: false, unique: true
      t.timestamps
    end
  end
end

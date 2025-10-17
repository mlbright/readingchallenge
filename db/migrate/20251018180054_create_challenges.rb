class CreateChallenges < ActiveRecord::Migration[8.0]
  def change
    create_table :challenges do |t|
      t.string :name, null: false
      t.text :description
      t.date :due_date, null: false
      t.integer :veto_threshold, null: false, default: 1
      t.integer :creator_id, null: false

      t.timestamps
    end
    
    add_index :challenges, :creator_id
    add_foreign_key :challenges, :users, column: :creator_id
  end
end

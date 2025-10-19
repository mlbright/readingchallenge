class AddDefaultBookGoalToChallenges < ActiveRecord::Migration[8.0]
  def change
    add_column :challenges, :default_book_goal, :integer, default: 12, null: false
  end
end

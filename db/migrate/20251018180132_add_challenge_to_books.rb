class AddChallengeToBooks < ActiveRecord::Migration[8.0]
  def change
    # Delete existing books since we're changing to challenge-based structure
    reversible do |dir|
      dir.up do
        execute "DELETE FROM books"
      end
    end
    
    add_reference :books, :challenge, null: false, foreign_key: true
  end
end

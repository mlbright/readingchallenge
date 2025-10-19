class ChangeVotesToVetos < ActiveRecord::Migration[8.0]
  def change
    # Remove the approved column, add veto_reason (allow null for now)
    remove_column :votes, :approved, :boolean
    add_column :votes, :veto_reason, :text

    # Delete existing votes since they don't have veto reasons
    # This is acceptable as we're changing the fundamental voting model
    reversible do |dir|
      dir.up do
        execute "DELETE FROM votes"
      end
    end
  end
end

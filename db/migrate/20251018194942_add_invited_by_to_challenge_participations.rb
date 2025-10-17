class AddInvitedByToChallengeParticipations < ActiveRecord::Migration[8.0]
  def change
    add_column :challenge_participations, :invited_by_id, :integer
    add_index :challenge_participations, :invited_by_id
    add_foreign_key :challenge_participations, :users, column: :invited_by_id
  end
end

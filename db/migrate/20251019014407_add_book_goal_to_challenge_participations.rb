class AddBookGoalToChallengeParticipations < ActiveRecord::Migration[8.0]
  def change
    add_column :challenge_participations, :book_goal, :integer

    # Set book_goal for existing participations from their challenge's default_book_goal
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE challenge_participations
          SET book_goal = (
            SELECT default_book_goal#{' '}
            FROM challenges#{' '}
            WHERE challenges.id = challenge_participations.challenge_id
          )
        SQL
      end
    end

    change_column_null :challenge_participations, :book_goal, false
  end
end

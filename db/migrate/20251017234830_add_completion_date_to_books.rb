class AddCompletionDateToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :completion_date, :date
  end
end

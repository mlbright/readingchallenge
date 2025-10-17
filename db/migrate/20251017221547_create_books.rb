class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :pages
      t.text :description
      t.string :url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

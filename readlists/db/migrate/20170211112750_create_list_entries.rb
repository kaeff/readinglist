class CreateListEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :list_entries do |t|
      t.integer :list_id
      t.integer :article_id
      t.integer :position

      t.timestamps
    end

    add_index :list_entries, [:list_id, :article_id]

  end
end

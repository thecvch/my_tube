class CreateVideoposts < ActiveRecord::Migration
  def change
    create_table :videoposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :videoposts, [:user_id, :created_at]
  end
end

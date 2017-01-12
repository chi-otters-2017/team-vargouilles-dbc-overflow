class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.integer :commentor_id, null: false
      t.integer :commentable_id, null: false

      t.timestamps(null: false)
    end
  end
end

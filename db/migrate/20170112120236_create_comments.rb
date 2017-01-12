class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.integer :commentor_id, null: false
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
      #Alternative syntax for declaration + index is:
        #t.references :commentable, polymorphic: true, index: true

      t.timestamps(null: false)
    end

    add_index :comments, [:commentable_type, :commentable_id]
  end
end

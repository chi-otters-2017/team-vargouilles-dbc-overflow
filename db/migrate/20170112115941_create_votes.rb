class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voter_id, null: false
      t.integer :value, null: false, default: 0
      t.integer :votable_id, null: false
      t.string :votable_type, null: false
      #Alternative syntax for declaration + index is:
        #t.references :votable, polymorphic: true, index: true

      t.timestamps(null: false)
    end

    add_index :votes, [:votable_type, :votable_id]
  end
end

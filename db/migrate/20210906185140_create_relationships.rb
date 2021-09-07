class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :followed_id
      t.integer :follower_id

      t.timestamps

    end
    add_index :relationships, %i[followed_id follower_id], unique: true
  end
end
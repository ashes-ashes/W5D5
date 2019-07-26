class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.integer :url_id, null: false
      t.integer :user_id, null: false
      t.index :url_id
      t.index :user_id
      t.timestamps
    end
  end
end

class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :short_link, unique: true, null: false
      t.string :link, unique: true, null: false
      t.integer :stat, null: false, default: 0
      t.timestamps
    end

    add_index :urls, :short_link, unique: true
  end
end

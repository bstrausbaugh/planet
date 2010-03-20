class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :name
      t.text :description
      t.references :iteration
      t.integer :tracker_id
      t.integer :customer_id
      t.integer :estimate
      t.integer :priority

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end

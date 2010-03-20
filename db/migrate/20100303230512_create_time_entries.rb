class CreateTimeEntries < ActiveRecord::Migration
  def self.up
    create_table :time_entries do |t|
      t.integer :duration
      t.integer :person1_id
      t.integer :person2_id
      t.references :task

      t.timestamps
    end
  end

  def self.down
    drop_table :time_entries
  end
end

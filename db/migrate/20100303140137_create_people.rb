class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :userid
      t.string :name
      t.string :email
      t.string :initials
      t.boolean :hidden

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end

class FixLaptopsOwner < ActiveRecord::Migration
  def self.up
    change_table :laptop_owners  do |t|
      t.boolean :finished 
    end
  end

  def self.down
  end
end

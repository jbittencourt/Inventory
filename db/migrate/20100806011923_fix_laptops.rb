class FixLaptops < ActiveRecord::Migration
  def self.up
    change_table :laptops  do |t|
      t.remove :id
      t.string :id, :size => 30, :primary_key => true
    end
  end

  def self.down
  end
end

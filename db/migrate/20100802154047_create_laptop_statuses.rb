class CreateLaptopStatuses < ActiveRecord::Migration
  def self.up
    create_table :laptop_statuses do |t|
      t.string :name
      t.string :severity
      t.timestamps
    end
  end

  def self.down
    drop_table :laptop_statuses
  end
end

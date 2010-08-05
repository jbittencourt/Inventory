class CreateLaptops < ActiveRecord::Migration
  def self.up
    create_table :laptops do |t|
      t.string :serial_namber
      t.integer :model_id
      t.integer :status_id
      t.references :owner, :polymorphic => true;
      
      t.float :longitude
      t.float :latitude
      
      t.timestamps
    end
  end

  def self.down
    drop_table :laptops
  end
end

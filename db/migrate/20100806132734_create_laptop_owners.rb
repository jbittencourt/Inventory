class CreateLaptopOwners < ActiveRecord::Migration
  def self.up
    change_table :laptops  do |t|
      t.remove :owner_id
      t.remove :owner_type
    end
    
    create_table :laptop_owners do |t|
      t.references :owner, :polymorphic => true;
      t.string :laptop_id
      t.date :finished_at
      t.string :finished_message
      t.timestamps
    end
  end

  def self.down
    drop_table :laptop_owners
  end
end

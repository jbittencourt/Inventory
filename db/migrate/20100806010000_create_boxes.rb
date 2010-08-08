class CreateBoxes < ActiveRecord::Migration
  def self.up
    
    create_table :boxes, :id => false, :primary_key => :id do |t|
      t.string :id, :size => 17
      t.string :shipment
    end
  end

  def self.down
    drop_table :boxes
  end
end

class LaptopsShipments < ActiveRecord::Migration
  def self.up
    create_table :laptops_shipments, :id=>false do |t|
      t.references :shipment
      t.references :laptop
      t.timestamps
    end
  end

  def self.down
  end
end

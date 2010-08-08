class AddSkuLaptop < ActiveRecord::Migration
  def self.up
    change_table :laptops  do |t|
      t.references :sku
      t.references :box
    end
  end

  def self.down
  end
end

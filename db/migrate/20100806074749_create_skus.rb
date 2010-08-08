class CreateSkus < ActiveRecord::Migration
  def self.up
    create_table :skus, :id=>false, :primary_key => :sku  do |t|
      t.string  :sku, :primary_key => true
      t.boolean :activation_key
      t.string  :keyboard_model
      t.string  :keyboard_layout
      t.string  :keyboard_variation
      t.string  :localization
      t.string  :keyboard_ascii
      t.string  :country_code
      t.string  :comments
      t.string  :memory
      t.string  :flash
      t.string  :adapter
      t.references :laptop_model
      t.timestamps
    end
  end

  def self.down
    drop_table :skus
  end
end

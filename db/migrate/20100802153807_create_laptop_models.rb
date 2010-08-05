class CreateLaptopModels < ActiveRecord::Migration
  def self.up
    create_table :laptop_models do |t|
      t.string :name
      t.string :manufacturer
      t.date :introduced_at
      t.timestamps
    end
  end

  def self.down
    drop_table :laptop_models
  end
end

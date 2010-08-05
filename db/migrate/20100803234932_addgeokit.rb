class Addgeokit < ActiveRecord::Migration
  def self.up
    add_column :schools, :latitude, :long
    add_column :schools, :longitude, :long
  end

  def self.down
  end
end

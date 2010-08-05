class Fixclassrooms < ActiveRecord::Migration
  def self.up
    add_column :classrooms, :school_id, :integer
    add_column :classrooms, :year, :integer
  end

  def self.down
  end
end

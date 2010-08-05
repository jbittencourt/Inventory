class CreateClassrooms < ActiveRecord::Migration
  def self.up
    create_table :classrooms do |t|
      t.string :name
      t.string :grade
      t.timestamps
    end
  end

  def self.down
    drop_table :classrooms
  end
end

class SchoolsAditionalInfo < ActiveRecord::Migration
  def self.up
    add_column :schools, :number_of_students, :integer
  end

  def self.down
  end
end

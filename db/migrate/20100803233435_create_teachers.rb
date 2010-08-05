class CreateTeachers < ActiveRecord::Migration
  def self.up
    add_column :schools, :head_of_school_id, :integer
    add_column :schools, :champion_teacher_id, :integer
    
    create_table :teachers do |t|
      t.string :name
      t.integer :national_id
      t.date :date_of_birth
      t.string :phone
      
      t.integer :school_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :teachers
  end
end

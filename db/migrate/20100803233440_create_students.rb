class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string  :name
      t.string  :mother_name
      t.integer :mother_national_id
      t.string  :responsible_name
      t.integer :responsible_national_id
      t.string  :responsible_kinship

      t.integer :classroom_id
      t.integer :school_id

      t.date :date_of_birth
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end

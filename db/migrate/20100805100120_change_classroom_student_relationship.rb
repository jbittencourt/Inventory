class ChangeClassroomStudentRelationship < ActiveRecord::Migration
  def self.up
     remove_column :students, :classroom_id
     create_table :classrooms_students,:id => false do |t|
        t.integer :student_id
        t.integer :classroom_id
        t.timestamps
      end
  end

  def self.down
  end
end

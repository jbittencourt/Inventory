require 'csv'

class StudentsController < ApplicationController
  
  def new_bulk
    @school = School.find(params[:school_id])
  end
  
  def process_bulk
    f = params[:students]['csv_file']
    @students = []
    f.read do |row|
      student = Student.new
      student.school_id = params[:school_id]
      student.name =  row[0]
      student.mother_name = row[1]
      student.mother_national_id = row[2]
      student.responsible_name = row[3]
      student.responsible_national_id = row[4]
      student.responsible_kindship = row[5]
      student.phone = row[6]
      student.date_of_birth = row[7]
      
      @students << student 
    end
  end
  
end

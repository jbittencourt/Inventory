require 'csv'

class StudentsController < ApplicationController
  
  def index
    @school = School.find(params[:school_id])
    @students = @school.students
  end
  
  def new_bulk
    @school = School.find(params[:school_id])
  end
  
  def process_bulk
    @school = School.find(params[:school_id])
    f = params[:student]['csv_file']
        
    @students = []
    @erros = false

    #discard the first line
    f.readline
    
    f.each_line do |line|
      row = CSV::parse_line(line,';')
      student = Student.new
      student.school_id = params[:school_id]
      student.name =  row[0]
      classroom = Classroom.find_by_name(row[1],:conditions=>"school_id=#{@school.id}")

      if classroom!=nil
        student.classrooms <<  classroom
      end
      
      student.mother_name = row[2]
      student.mother_national_id = row[3]
      student.responsible_name = row[4]
      student.responsible_national_id = row[5]
      student.responsible_kinship = row[6]
      student.phone = row[7]
      student.date_of_birth = row[8]
      @students << student 
      
      @errors = @errors || student.invalid?
      
    end    

    if ! @errors
      temp_file = File.new("#{Rails.root}/tmp/students_bulk_processed", "w")
      temp_file.print(Marshal::dump(@students))
      temp_file.close
      session[:students_bulk] = temp_file.path
    end
    
    respond_to do |format|
      format.html # process_bulk.html.erb
      format.xml  { render :xml => @students }
    end
    
  end
  
  def create_bulk
    @school = School.find(params[:school_id])
    
    #preload classes to avoid Marshal problems
    Student.class
    Classroom.class
    
    
    all_saved = true
    if ! session[:students_bulk].blank?
      f = File.open(session[:students_bulk]) 
      @students = Marshal::load(f,nil)
      @students.each do |student|
        debugger
        all_saved =  student.save && all_saved
      end
    end
    
    respond_to do |format|
      if all_saved
        flash[:notice] = 'Students sucessfully added to School.'
        format.html { redirect_to(@school) }
        format.xml  { render :xml => @school, :status => :created, :location => @school }
      else
        format.html { render :action => "process_bulk" }
        format.xml  { render :xml => @school.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  
end

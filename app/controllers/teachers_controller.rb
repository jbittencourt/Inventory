class TeachersController < ApplicationController
  
  # GET /schools/new
  # GET /schools/new.xml
  def new
    @school = School.find(params[:school_id])
    @teacher = Teacher.new
    @teacher.school_id = @school.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @school }
    end
  end
  
  def create
    @teacher = Teacher.new(params[:teacher])
    @school = @teacher.school
    render :update do |page|    
      if @teacher.save
        @teachers = @school.teachers
        @teacher = Teacher.new
        @teacher.school = @school
        page.replace_html "teachers-list", :partial => "teachers_list",  :locals => { :teachers => @school.teachers }
        page.replace_html "teacher-form", :partial => "form",  :locals => { :teacher => @teacher, :school => @school } 
      else
        page.replace_html "teacher-form", :partial => "form",  :locals => { :teacher => @teacher, :school => @school } 
      end
    end
      
  end
  
end

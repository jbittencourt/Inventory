class ClassroomsController < ApplicationController

  def show
    @classroom = Classroom.find(params[:id])
    @school = @classroom.school
  end

  # GET /schools/new
  # GET /schools/new.xml
  def new
    @school = School.find(params[:school_id])
    @classroom = Classroom.new
    @classroom.school_id = @school.id
    @classroom.year = Date.today().year()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @school }
    end
  end
  
  def create
    @classroom = Classroom.new(params[:classroom])
    @school = @classroom.school
    render :update do |page|    
      if @classroom.save
        @classrooms = @school.classrooms
        @classroom = Classroom.new
        @classroom.year = Date.today().year()
        @classroom.school = @school
        page.replace_html "classrooms-list", :partial => "classrooms_list",  :locals => { :classrooms => @school.classrooms }
        page.replace_html "classroom-form", :partial => "form",  :locals => { :classroom => @classroom, :school => @school } 
      else
        page.replace_html "classroom-form", :partial => "form",  :locals => { :classroom => @classroom, :school => @school } 
      end
    end
      
  end
end

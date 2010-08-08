class InventoryController < ApplicationController
  
  
  def new_inventory
    @districts = District.find(:all,:order=>'name ASC')
  end
  
  def get_schools
    @schools = School.find(:all, 
      :joins => "LEFT JOIN sectors ON schools.sector_id=sectors.id",
      :conditions => ['district_id=?',params[:school_district_id] ],
      :order => 'name ASC'
      )
    
    options = ""
    for school in @schools
      options +=   "<option value='#{school.id}'>#{school.name}</option>"
    end
      
    render :inline => options
  end
  
  def get_classrooms
    school = School.find(params[:school_id])
    
    
    
    if school.classrooms.blank?
      render :status => '404' , :inline => "This school has no classrooms registered."
    else
      options = "<option value='teachers'>Teachers</option>"
      for classrooms in school.classrooms
        options +=   "<option value='#{classrooms.id}'>#{classrooms.name}</option>"
      end
      render :inline => options
    end
      
    
  end

  
  def inventory
    @school = School.find(params[:school][:id])
    if params[:school][:classroom_id]=="teachers"
      @teachers = @school.teachers
      respond_to do |format|
        format.html { render :action=>"inventory_teachers" }
      end
    else
      @classroom = Classroom.find(params[:school][:classroom_id])
      respond_to do |format|
        format.html { render :action=>"inventory_students" }
      end
    end
  end
  
  def attribute_laptop
    if params[:owner_type]=='student'
      owner = Student.find(params[:owner_id])
    else 
      owner = Teacher.find(params[:owner_id])
    end
    laptop = Laptop.find_by_serial_number(params[:serial_number])
    
    if laptop==nil
        render :status=>404,:inline => "There isn't any laptop registered with this serial number."
    else
      if laptop.owner == nil
        owner.laptop = laptop
        if owner.valid?
          render :partial => "laptop_inventory_item", :locals => { :owner_type => params[:owner_type] ,:owner => owner, :cont=>params[:cont] }
        else 
          render :status=>404,:inline => owner.errors.full_messages.map {|m| "<p>#{m}</p>" }
        end
      else
        render :status=>404,:inline => "This laptop already have an owner."
      end
    end

  end
  
  def unlink_laptop
    if params[:owner_type]=='student'
      owner = Student.find(params[:owner_id])
    else 
      owner = Teacher.find(params[:owner_id])
    end
    
    rel = owner.current_laptop_relation
    
    rel.finished = true
    rel.finished_at = Time.now
    rel.finished_message = "Ended relationship during Inventory Form at "+Time.now.to_s
    if rel.save
      render :partial => "laptop_inventory_form", :locals => { :owner_type => params[:owner_type], :owner => owner, :cont=>params[:cont] }
    end
  end
  
end

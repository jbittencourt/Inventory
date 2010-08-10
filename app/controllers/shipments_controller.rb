class ShipmentsController < ApplicationController
  
  def get_schools
    @schools = School.find(:all, 
      :joins => "LEFT JOIN sectors ON schools.sector_id=sectors.id",
      :conditions => ['district_id=?',params[:district_id] ],
      :order => 'name ASC'
      )
      
    render :partial=>"schools_select"
  end
  
  def new
    @shipment = Shipment.new
    @districts = District.find(:all,:order=>'name ASC')
    @status = LaptopStatus.find(:all)
  end
  
  def create
    @shipment = Shipment.new(params[:shipment])
    @status = LaptopStatus.find(params[:laptop_status_id])
    @laptops = Laptop.find_by_sql("SELECT l.* FROM laptops l LEFT JOIN laptop_owners lo ON lo.laptop_id=l.id LEFT JOIN students s ON lo.owner_id=s.id WHERE (lo.owner_type='Student' AND lo.finished=0 AND s.school_id=#{@shipment.school_id}) ORDER BY l.box_id ")
    
    respond_to do |format|
      if @shipment.save
        flash[:notice] = "shipment Successfuly Added"
        format.html { render :action => 'create' }
        format.xml  { render :xml => @shipment, :status => :created, :location => @shipment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shipment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def add_laptop
    shipment = Shipment.find(params[:shipment_id])
    laptop = Laptop.find_by_serial_number(params[:serial_number])
    
    render :update do |page|

      page.visual_effect  'highlight', "laptop_#{laptop.id}", { :endcolor => '#FFFF99', :restorecolor =>'#FFFF99' }
    end
  end
  
end

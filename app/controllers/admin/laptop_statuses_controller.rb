class Admin::LaptopStatusesController < ApplicationController
  
  def show
    @laptop_status = LaptopStatus.find(params[:id])
  end
  
  def new
    @laptop_status = LaptopStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @laptop_status }
    end
  end
  
  def create
    @laptop_status = LaptopStatus.new(params[:laptop_status])
    
    respond_to do |format|
      if @laptop_status.save
        flash[:notice] = "Laptop Status Successfuly Added"
        format.html { redirect_to("/admin") }
        format.xml  { render :xml => @laptop_status, :status => :created, :location => @laptop_status }
      else
        format.html { render :controller => :laptop_statuss, :action => "new" }
        format.xml  { render :xml => @laptop_status.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @laptop_status = LaptopStatus.find(params[:id])
  end

  # PUT /documents/1
  # PUT /documents/1.xml
  def update
    @laptop_status = LaptopStatus.find(params[:id])

    respond_to do |format|
      if @laptop_status.update_attributes(params[:laptop_status])
        flash[:notice] = "Laptop Model Successfully Updated"
        format.html { redirect_to("/admin") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @laptop_status.errors, :status => :unprocessable_entity }
      end
    end
  end
end

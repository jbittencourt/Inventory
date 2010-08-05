class Admin::LaptopModelsController < ApplicationController
  
  
  def show
    @laptop_model = LaptopModel.find(params[:id])
  end
  
  def new
    @laptop_model = LaptopModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @laptop_model }
    end
  end
  
  def create
    @laptop_model = LaptopModel.new(params[:laptop_model])
    
    respond_to do |format|
      if @laptop_model.save
        flash[:notice] = "Laptop Model Successfuly Added"
        format.html { redirect_to("/admin") }
        format.xml  { render :xml => @laptop_model, :status => :created, :location => @laptop_model }
      else
        format.html { render :controller => :laptop_models, :action => "new" }
        format.xml  { render :xml => @laptop_model.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @laptop_model = LaptopModel.find(params[:id])
  end

  # PUT /documents/1
  # PUT /documents/1.xml
  def update
    @laptop_model = LaptopModel.find(params[:id])

    respond_to do |format|
      if @laptop_model.update_attributes(params[:laptop_model])
        flash[:notice] = "Laptop Model Successfully Updated"
        format.html { redirect_to("/admin") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @laptop_model.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
end

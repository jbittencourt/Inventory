class CountryController < ApplicationController
  
  def index
    @sectors = Sector.find(:all)
    @districts = District.find(:all)
    @provinces = Province.find(:all)
  end
  
  def new_sector
    @sector = Sector.new
    @districts = District.find(:all)

    
    respond_to do |format|
      format.html # new_sector.html.erb
      format.xml  { render :xml => @sector }
    end
  end
  
  def create
    @sector = Sector.new(params[:sector])
    
    respond_to do |format|
      if @sector.save
        flash[:notice] = "Sector Successfuly Added"
        format.html { redirect_to(:action => 'index') }
        format.xml  { render :xml => @sector, :status => :created, :location => @sector }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sector.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  
end

require 'csv'

class LaptopsController < ApplicationController
  
  def index
  end
  
  def new
    @status = LaptopStatus.find(:all)
  end
  
  def process_file
    f = params[:laptop]['csv_file']
    laptop_status = LaptopStatus.find(params[:laptop][:status])
    @laptops = []
    @erros = false

    #discard the first line
    f.readline
    
    f.each_line do |line|
      row = CSV::parse_line(line,';')
      laptop = Laptop.new
      sku = Sku.find_by_sku(row[4])
      model = sku.laptop_model
      box = Box.find_or_create_by_id(row[2])
      if box.shipment == nil
        box.shipment = row[0]
        box.save
      end
      
      laptop.id = row[5]
      laptop.status = laptop_status
      laptop.serial_number =  row[3]
      laptop.model = model
      laptop.box_id = box.id
      laptop.sku = sku
      
      @laptops << laptop 
      
      @errors = @errors || laptop.invalid?
      
    end    

    if ! @errors
      temp_file = File.new("#{Rails.root}/tmp/laptops_bulk_processed", "w")
      temp_file.print(Marshal::dump(@laptops))
      temp_file.close
      session[:laptops_bulk] = temp_file.path
    end
    
    respond_to do |format|
      format.html # process_bulk.html.erb
      format.xml  { render :xml => @laptops }
    end
    
  end
  
  def create
    #preload classes to avoid Marshal problems
    Laptop.class
    LaptopModel.class
    Sku.class
    Box.class
    LaptopStatus.class
    
    
    all_saved = true
    if ! session[:laptops_bulk].blank?
      f = File.open(session[:laptops_bulk]) 
      @laptops = Marshal::load(f,nil)
      @laptops.each do |laptop|
        all_saved =  laptop.save && all_saved
      end
    end
    
    respond_to do |format|
      if all_saved
        flash[:notice] = 'Laptops sucessfully registered.'
        format.html { redirect_to(laptops_path) }
        format.xml  { render :xml => @school, :status => :created, :location => @school }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @school.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def list_boxes
    @boxes = Box.find(:all)
  end

  
end

class Admin::AdmController < ApplicationController
  
  def index
    @laptop_statuses = LaptopStatus.find(:all)
    @laptop_models = LaptopModel.find(:all)
  end
  
end

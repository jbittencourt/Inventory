class Laptop < ActiveRecord::Base
  belongs_to :model, :class_name => "LaptopModel"
  belongs_to :status, :class_name => "LaptopStatus"
  
end

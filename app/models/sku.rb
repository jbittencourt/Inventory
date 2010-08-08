class Sku < ActiveRecord::Base
  set_primary_key :sku 
  
  belongs_to :laptop_model
end

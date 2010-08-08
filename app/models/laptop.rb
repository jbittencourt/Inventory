class Laptop < ActiveRecord::Base
  attr :owner
  
  belongs_to :model, :class_name => "LaptopModel"
  belongs_to :status, :class_name => "LaptopStatus"
  belongs_to :box
  belongs_to :sku

  has_many   :laptop_owners
  
  validates_presence_of :serial_number
  validates_uniqueness_of :serial_number
  
  def owner
    rel = self.laptop_owners.find(:first, :conditions=>"finished=0")
    return rel.owner unless rel == nil
  end

  def owner=(owner)
    rel = LaptopOwner.new
    rel.laptop = self
    rel.owner = owner
    rel.finished = false
    self.laptop_owners << rel
  end
  
  
end

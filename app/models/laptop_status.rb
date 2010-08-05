class LaptopStatus < ActiveRecord::Base
  has_many :laptops
  
  validates_presence_of :name
  validates_presence_of :severity
  
  def severity_options
    return ['working','maintenance','dismantled','unknow']
  end
  
end

class LaptopModel < ActiveRecord::Base
  has_many :laptops
  has_attached_file :picture, :styles => {:thumb=>"80x80#",
                                          :icon=>"20x20#",
                                          :medium=>"150x150>",
                                          :big=>"300x300>"}
  
  validates_presence_of :name
  validates_presence_of :manufacturer
  validates_uniqueness_of :name
  
  validates_attachment_content_type :picture, :content_type => [ 'image/jpeg', 'image/png', 'image/gif' ]
  
  
  
end

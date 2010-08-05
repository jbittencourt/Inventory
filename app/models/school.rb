class School < ActiveRecord::Base
  attr_accessor :sector_name
  validate :validates_existance_of_sector
  
  belongs_to :head_of_school, :class_name => "Teachers"
  belongs_to :champion_teacher, :class_name => "Teachers"
  belongs_to :sector
  
  has_many   :teachers
  has_many   :students
  has_many   :classrooms
  
  validates_presence_of :name
  validates_numericality_of :longitude, :allow_blank=>true
  validates_numericality_of :latitude, :allow_blank=>true
  
  def validates_existance_of_sector
      errors.add(:sector_name, "isn't valid. Please check if this sector really exists.") if self.sector == nil
  end
  
  def sector_name
    if !self.sector.blank? then
      self.sector.name
    end
  end
  
  def sector_name=(name)
    sector = Sector.find_by_name(name)
    if(sector!=nil) then
      self.sector_id = sector.id
    end
  end
  
end

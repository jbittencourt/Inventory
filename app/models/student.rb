class Student < ActiveRecord::Base
  attr :laptop
  belongs_to :school
  has_and_belongs_to_many :classrooms, :order => "year DESC"
  has_many   :laptop_owners, :as => :owner
  
  validate :validates_presence_of_classrooms, :validates_single_laptop
  validates_presence_of :name
  validates_presence_of :mother_name
  validates_presence_of :mother_national_id
  validates_presence_of :responsible_name
  validates_presence_of :responsible_national_id
  
  validates_associated  :classrooms

  def classroom
    if !self.classrooms.blank?
      return self.classrooms.first
    end
  end

  def validates_presence_of_classrooms
    errors.add_to_base "The user must belong to at least one valid classroom." if self.classrooms.blank?
  end
  
  def validates_single_laptop
    if ! self.laptop_owners.empty?
      laptops = self.laptop_owners.find_by_owner_id(:self.id,:conditions=>["finished=0"],:order=>"created_at DESC")
      if laptops!=nil
        errors.add_to_base "A student might only have one laptop per time." if laptops.length > 1
      end
    end
  end
  
  def current_laptop_relation
    return self.laptop_owners.find(:first,:conditions=>"finished=0",:order=>"created_at DESC")
  end
  
  def laptop
    rel = self.laptop_owners.find(:first,:conditions=>"finished=0",:order=>"created_at DESC")
    if rel != nil
      return rel.laptop
    end
  end

  def laptop=(laptop)
    rel = LaptopOwner.new
    rel.owner = self
    rel.laptop = laptop
    rel.finished = false
    self.laptop_owners << rel
  end

end

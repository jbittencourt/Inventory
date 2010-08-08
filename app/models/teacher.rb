class Teacher < ActiveRecord::Base
  attr :laptop
  
  belongs_to :school
  has_many   :laptop_owners, :as => :owner
  
  validates_presence_of :name
  validates_numericality_of :national_id
  validates_uniqueness_of :national_id
  
  def date_of_birth_at_string
    if(self.date_of_birth!=nil) then 
      self.date_of_birth.to_s(:db)
    end
  end

  def date_of_birth_at_string=(date_of_birth_str)
    self.date_of_birth = Time.parse(date_of_birth_str)
  rescue ArgumentError
    @date_of_birth_at_invalid = true
  end
  
  def validates_single_laptop
    if ! self.laptop_owners.empty?
      laptops = self.laptop_owners.find_by_owner_id(:self.id,:conditions=>["finished=0"])
      errors.add_to_base "A student might only have one laptop per time." if laptops.length > 1
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

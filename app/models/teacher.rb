class Teacher < ActiveRecord::Base
  belongs_to :school
  
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
end

class Student < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :classrooms, :order => "year DESC"

end

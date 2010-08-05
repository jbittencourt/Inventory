class Classroom < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :students
  
  def grades
    return ['Primary 1',
      'Primary 2',
      'Primary 3',
      'Primary 4',
      'Primary 5',
      'Primary 6',
      'Senior 1',
      'Senior 2',
      'Senior 3',
      ]
  end
end

class Project < ActiveRecord::Base
  has_many :iterations
  has_one :current_iteration,
          :class_name => 'Iteration',
          :conditions => ['? between start_on and end_on', Date.today]

  validates_presence_of :name
  
end

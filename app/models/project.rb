class Project < ActiveRecord::Base
  has_many :iterations, :order => 'start_on DESC'
  has_one :current_iteration,
          :class_name => 'Iteration',
          :conditions => ['? between start_on and end_on', Date.today]

  validates_presence_of :name

  before_create :initialize_hidden_field

  protected

  def initialize_hidden_field
    self.hidden = false if self.hidden.nil?
    true
  end

end

class Task < ActiveRecord::Base
  belongs_to :story
  has_many :time_entries
  belongs_to :acceptor, :class_name => 'Person'

  validates_presence_of :name
  
  attr_accessor :work
  def actual
    return @work unless @work.nil? # only calc once
    @work = 1 + rand(self.estimate) 
    return 0 if self.estimate.nil? || @work > self.estimate
    @work 
  end

  def remaining
    return 0 if self.estimate.nil?
    self.estimate - actual 
  end
  
end

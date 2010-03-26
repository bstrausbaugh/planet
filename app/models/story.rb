class Story < ActiveRecord::Base
  belongs_to :iteration
  has_many :tasks
  belongs_to :tracker, :class_name => 'Person'

  validates_presence_of :name
  validates_numericality_of :priority, :estimate

  def percent_complete
    #return 0 if self.estimate.nil?
    (actual.to_f / self.estimate.to_f * 100.0).to_i
  end
  
  def task_count
    2
  end

  attr_accessor :work
  def actual
    return @work unless @work.nil? # only calc once
    @work = 1 + rand(self.estimate) 
    return 0 if self.estimate.nil? || @work > self.estimate
    @work 
  end

  def remaining
    self.estimate - actual 
  end

end

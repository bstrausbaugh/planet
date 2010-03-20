class TimeEntry < ActiveRecord::Base
  belongs_to :task
  belongs_to :person1, :class_name => 'Person'
  belongs_to :person2, :class_name => 'Person'

  validates_presence_of :person1
  validate :duration_must_be_greater_than_zero

  protected
  def duration_must_be_greater_than_zero
    errors.add(:duration, 'should be > 0') if duration.nil? || duration < 1
  end

end

require 'test_helper'

class TimeEntryTest < ActiveSupport::TestCase

  def setup
    @time_entry = TimeEntry.new
    @time_entry.person1 = Person.new
    @time_entry.duration = 1
  end

  test "the target TimeEntry should be valid" do
    assert @time_entry.valid?
  end

  test "a TimeEntry should have a duration > 0" do
    @time_entry.duration = 0
    assert !@time_entry.valid?
    assert @time_entry.errors.invalid?(:duration)

    @time_entry.duration = -1
    assert !@time_entry.valid?
    assert @time_entry.errors.invalid?(:duration)

    @time_entry.duration = 1
    assert @time_entry.valid?
  end

  test "a TimeEntry should have a person1" do
    @time_entry.person1 = nil
    assert !@time_entry.valid?
    assert @time_entry.errors.invalid?(:person1)
  end

end

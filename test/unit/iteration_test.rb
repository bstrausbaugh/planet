require 'test_helper'
require 'timecop'

class IterationTest < ActiveSupport::TestCase

  test "an iteration should have a start date" do
    iteration = Iteration.new
    assert !iteration.valid?
    assert iteration.errors.invalid?(:start_on)
  end

  test "an iteration should have an end date" do
    iteration = Iteration.new
    assert !iteration.valid?
    assert iteration.errors.invalid?(:end_on)
  end

  #test "an iteration start date should be before the end date"

  #test "an iterations start date should not overlap other iterations for a project unless it is the same iteration"

  test "an iterations start date should not overlap other iterations for a project" do
    iteration_three = iterations(:iteration_three)

    iteration = Iteration.new
    iteration.project = iteration_three.project
    iteration.start_on = iteration_three.end_on
    iteration.end_on = iteration.start_on + 8
    assert !iteration.valid?
    assert iteration.errors.invalid?(:start_on)

    iteration.start_on = iteration_three.end_on + 1
    assert iteration.valid?
    iteration.save!
    assert iteration.valid?
  end

  test "an iterations end date should not overlap other iterations for a project" do
    iteration_zero = iterations(:iteration_zero)

    iteration = Iteration.new
    iteration.project = iteration_zero.project
    iteration.start_on = iteration_zero.start_on - 8
    iteration.end_on = iteration_zero.start_on
    assert !iteration.valid?
    assert iteration.errors.invalid?(:end_on)

    iteration.end_on = iteration_zero.start_on - 1
    assert iteration.valid?
  end

  test "an iterations start and end dates can overlap with other projects" do
    iteration_zero = iterations(:iteration_zero)

    iteration = Iteration.new
    iteration.project = iteration_zero.project
    iteration.start_on = iteration_zero.start_on
    iteration.end_on = iteration_zero.end_on
    assert !iteration.valid?
    assert iteration.errors.invalid?(:start_on)
    assert iteration.errors.invalid?(:end_on)

    iteration.project = projects(:online_orders)
    assert iteration.valid?
  end

  test "an iteration.to_s should include year if start/end date during different year" do
    fixed_date = Time.local(2009, 12, 15)
    Timecop.travel(fixed_date) {
      iteration = Iteration.new
      iteration.start_on = Time.local(2010, 01, 31)
      iteration.end_on = Time.local(2010, 02, 13)
      assert_equal "01/31/2010 - 02/13/2010", iteration.to_s

      iteration.name = " "
      assert_equal "01/31/2010 - 02/13/2010", iteration.to_s

      iteration.start_on = Time.local(2009, 12, 31)
      assert_equal "12/31/2009 - 02/13/2010", iteration.to_s
    }
  end

  test "an iteration.to_s should print the start/end date as mm/dd if no name is present" do
    fixed_date = Time.local(2010, 01, 15)
    Timecop.travel(fixed_date) {
      iteration = Iteration.new
      iteration.start_on = Time.local(2010, 01, 31)
      iteration.end_on = Time.local(2010, 02, 13)
      assert_equal "01/31 - 02/13", iteration.to_s

      iteration.name = " "
      assert_equal "01/31 - 02/13", iteration.to_s
    }
  end

  test "an iteration.to_s should print the name if present" do
    iteration = Iteration.new
    iteration.start_on = Time.local(2010, 01, 31)
    iteration.end_on = Time.local(2010, 02, 13)
    iteration.name = "Iteration Zero"
    assert_equal "Iteration Zero", iteration.to_s
  end

end

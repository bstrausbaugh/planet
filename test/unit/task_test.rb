require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test "a task should have a name" do
    task = Task.new
    assert !task.valid?
    assert task.errors.invalid?(:name)
  end

end

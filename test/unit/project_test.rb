require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "a project should have a name" do
    project = Project.new
    assert !project.valid?
    assert project.errors.invalid?(:name)
  end

  test "today should be between project.current_iteration start_on and end_on" do
    project = projects(:registration)
    assert_equal iterations(:iteration_two), project.current_iteration
  end

end

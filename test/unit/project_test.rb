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

  test "a new project's hidden field should be false and not nil" do
    project = Project.new
    project.name = "Test"
    project.save

    assert_not_nil project.hidden
    assert !project.hidden?
  end

end

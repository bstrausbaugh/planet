require 'test_helper'

class StoryTest < ActiveSupport::TestCase

  test "a story should have a name" do
    story = Story.new
    assert !story.valid?
    assert story.errors.invalid?(:name)
  end

end

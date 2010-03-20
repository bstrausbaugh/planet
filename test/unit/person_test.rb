require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  def setup
    @person = valid_person
  end

  test "the target Person should be valid" do
    assert @person.valid?
  end

  test "a Person should have a userid" do
    @person.userid = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:userid)
  end

  test "a Person should have a name" do
    @person.name = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:name)
  end

  test "a Person should have initials" do
    @person.initials = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:initials)
  end

  test "a Person's initials should be between 2 and 5 characters" do
    @person.initials = "x"
    assert !@person.valid?
    assert @person.errors.invalid?(:initials)

    @person.initials = "x" * 2
    assert @person.valid?

    @person.initials = "x" * 5
    assert @person.valid?

    @person.initials = "x" * 6
    assert !@person.valid?
    assert @person.errors.invalid?(:initials)
  end

  test "a Person's initials should be stored lowercase" do
    @person.initials = "TCK"
    assert_equal "tck", @person.initials
  end

  test "a Person's userid, initials, and email should be unique" do
    @person.save!

    person = valid_person
    assert !person.valid?
    assert_equal error_msg(:taken), person.errors.on(:userid)
    assert_equal error_msg(:taken), person.errors.on(:initials)
    assert_equal error_msg(:taken), person.errors.on(:email)
  end

  test "a Person should have an email" do
    @person.email = nil
    assert !@person.valid?
    assert @person.errors.invalid?(:email)
  end

  test "a Person should allow valid email addresses" do
    valid_endings = %w{com org net edu es jp info}
    valid_emails = valid_endings.collect do |ending|
      "foo.bar_1-9@baz-quux0.example.#{ending}"
    end
    valid_emails.each do |email|
      @person.email = email
      assert @person.valid?, "#{email} must be a valid email address"
    end
  end

  test "a Person should reject invalid email addresses" do
    invalid_emails = %w{foobar@example.c @example.com f@com foo@bar..com
                        foobar@example.infod foobar.example.com
                        foo,@example.com foo@ex(ample.com foo@example,com}
    invalid_emails.each do |email|
      @person.email = email
      assert !@person.valid?, "#{email} tests as valid but shouldn't be"
      assert_equal "must be a valid email address", @person.errors.on(:email)
    end
  end

  private

  def valid_person
    person = Person.new
    person.userid = "tkuntz"
    person.name = "Tim Kuntz"
    person.initials = "tck"
    person.email = "timkuntz@gmail.com"
    person
  end

  def error_msg(label)
    I18n.t label, :scope => 'activerecord.errors.messages'
  end

end

class Person < ActiveRecord::Base

  validates_presence_of :userid, :name, :initials, :email
  validates_uniqueness_of :userid, :initials, :email
  validates_length_of :initials, :within => 2..5
  validates_format_of :email,
                      :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                      :message => "must be a valid email address"

  def initials=(initials)
    self[:initials] = (initials ? initials.downcase : initials)
  end

end

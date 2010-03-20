class Task < ActiveRecord::Base
  belongs_to :story
  has_many :time_entries
  belongs_to :acceptor, :class_name => 'Person'

  validates_presence_of :name
end

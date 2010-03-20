class Story < ActiveRecord::Base
  belongs_to :iteration
  has_many :tasks
  belongs_to :customer, :class_name => 'Person'
  belongs_to :tracker, :class_name => 'Person'

  validates_presence_of :name
end

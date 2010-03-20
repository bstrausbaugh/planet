class Iteration < ActiveRecord::Base
  belongs_to :project
  has_many :stories

  validates_presence_of :start_on, :end_on
  validate :dates_should_not_overlap_for_project

  def dates_should_not_overlap_for_project
    return if project.nil?
    errors.add(:start_on, 'overlaps with existing iteration for this project') if find_overlapping_iteration(start_on)
    errors.add(:end_on, 'overlaps with existing iteration for this project') if find_overlapping_iteration(end_on)
  end

  def to_s
    return name unless name.blank?
    mdY = "%m/%d/%Y"
    md = "%m/%d"
    if start_on.year == Time.now.year && end_on.year == Time.now.year
      return "#{start_on.strftime(md)} - #{end_on.strftime(md)}"
    end
    "#{start_on.strftime(mdY)} - #{end_on.strftime(mdY)}"
  end

  private

  def find_overlapping_iteration(date)
    return Iteration.find(:first, :conditions => ["? between start_on and end_on and project_id = ?", date, project]) if new_record?
    Iteration.find(:first, :conditions => ["? between start_on and end_on and project_id = ? and id != ?", date, project, self])
  end
end

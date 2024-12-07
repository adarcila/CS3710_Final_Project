class Favorite < ApplicationRecord
  belongs_to :student
  belongs_to :ai_tool

  #Testing
  validates :student, presence: true
  validates :ai_tool, presence: true
  validates_uniqueness_of :ai_tool_id, scope: :student_id
end

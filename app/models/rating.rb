class Rating < ApplicationRecord
  belongs_to :ai_tool
  belongs_to :student
end

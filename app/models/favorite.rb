class Favorite < ApplicationRecord
  belongs_to :student
  belongs_to :ai_tool
end

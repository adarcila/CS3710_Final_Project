class AiTool < ApplicationRecord
    # Ensure all attributes are present
    validates :name, presence: true
    validates :description, presence: true
    validates :features, presence: true

    def self.ransackable_attributes(auth_object = nil)
      ["name", "description", "features", "created_at", "updated_at"]
    end
    
  end
  
class AiTool < ApplicationRecord
    # Ensure all attributes are present
    validates :name, presence: true
    validates :description, presence: true
    validates :features, presence: true

    #Favorite Connection
    has_many :favorites, dependent: :destroy
    has_many :favorited_by_students, through: :favorites, source: :student

    def self.ransackable_attributes(auth_object = nil)
      ["name", "description", "features", "created_at", "updated_at"]
    end
    
  end
  
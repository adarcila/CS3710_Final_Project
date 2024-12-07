class Student < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Active Storage for profile picture
  has_one_attached :profile_picture, dependent: :purge_later

  # Portfolio association
  has_one :portfolio, dependent: :destroy
  after_create :create_portfolio
  accepts_nested_attributes_for :portfolio

  # Favorites associations
  has_many :favorites, dependent: :destroy
  has_many :favorite_ai_tools, through: :favorites, source: :ai_tool

  # Validations
  validates :first_name, :last_name, presence: true
  validate :acceptable_image

  private

  def create_portfolio
    Portfolio.create!(student: self, active: false)
  end

  def acceptable_image
    return unless profile_picture.attached?

    unless profile_picture.blob.byte_size <= 1.megabyte
      errors.add(:profile_picture, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(profile_picture.content_type)
      errors.add(:profile_picture, "must be a JPEG or PNG")
    end
  end
end

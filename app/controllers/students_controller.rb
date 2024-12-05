class Student < ApplicationRecord
  # Include default devise modules. Others available are: 
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Using Active Storage to have one profile picture associated
  has_one_attached :profile_picture, dependent: :purge_later 

  # Has one relationship and destroy portfolio if student deleted
  has_one :portfolio, dependent: :destroy

  # After student created, create and link portfolio
  after_create :create_portfolio
  # Allow editing of portfolio information in form
  accepts_nested_attributes_for :portfolio

  # Validations
  validates :first_name, :last_name, presence: true
  validate :acceptable_image

  private

  # Create portfolio when student created
  def create_portfolio
      Portfolio.create!(student: self, active: false)
  end

  # Validate profile picture
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

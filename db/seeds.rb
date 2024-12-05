require 'faker' # Ensure the Faker gem is installed
require 'open-uri' # To open the image URL

# Purge existing profile photos and remove associated blobs and attachments
Student.find_each do |student|
  student.profile_picture.purge if student.profile_picture.attached?
end

# Ensure there are no orphaned attachments or blobs
ActiveStorage::Blob.where.missing(:attachments).find_each(&:purge)

# Destroy existing records
Portfolio.destroy_all
Student.destroy_all

50.times do |i|
  student = Student.create!(
    first_name: "First #{i + 1}",
    last_name: "Last #{i + 1}",
    email: "student#{i + 1}@msudenver.edu",
    password: "password",
    password_confirmation: "password",
    major: Student::VALID_MAJORS.sample,
    expected_graduation_date: Faker::Date.between(from: 2.years.ago, to: 2.years.from_now)
  )

  # Create a portfolio for the student
  Portfolio.create!(
    student: student,
    preferred_email: "student#{i + 1}@gmail.com",
    active: [true, false].sample,
    summary: Faker::Lorem.sentence(word_count: 20),
    skills: Faker::Lorem.words(number: 5).join(", ")
  )

  # Create AI Tools
  begin
    AiTool.find_or_create_by!(
      logo_url: "https://logos-world.net/wp-content/uploads/2024/11/Midjourney-Logo-500x281.png",
      name: "MidJourney",
      description: "AI-powered image generation tool",
      features: "art, creativity, photo realism, images",
      website_url: "https://www.midjourney.com"
    )
  rescue => e
    puts "Error creating AI Tool MidJourney: #{e.message}"
  end

  begin
    AiTool.find_or_create_by!(
      logo_url: "https://logos-world.net/wp-content/uploads/2023/02/ChatGPT-Logo-500x281.png",
      name: "ChatGPT",
      description: "Conversational AI for natural language processing",
      features: "language, conversation, AI assistant",
      website_url: "https://openai.com/chatgpt"
    )
  rescue => e
    puts "Error creating AI Tool ChatGPT: #{e.message}"
  end

  # Generate a unique profile pic based on the student's name
  profile_picture_url = "https://robohash.org/#{student.first_name.gsub(' ', '')}"
  profile_picture = URI.open(profile_picture_url)
  student.profile_picture.attach(io: profile_picture, filename: "#{student.first_name}.jpg")
end

puts "50 students created."

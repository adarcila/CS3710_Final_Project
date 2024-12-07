# spec/factories/ai_tools.rb
FactoryBot.define do
    factory :ai_tool do
      name { "Sample AI Tool" }
      category { "Art Generator" } # Adjust attributes as needed
      description { "Generates art based on input." }
    end
  end
  
  # spec/factories/users.rb
  FactoryBot.define do
    factory :user do
      name { "Test User" }
      # Add other necessary attributes
    end
  end
  
require 'rails_helper'

RSpec.describe Favorite, type: :model do
 
  # 1 Validations
  it 'is valid with a student and an AI tool' do
    student = Student.create(name: "Test Student") # Adjust attributes as necessary
    ai_tool = AiTool.create(name: "Test AI Tool")  # Adjust attributes as necessary
    favorite = Favorite.new(student: student, ai_tool: ai_tool)
    
    expect(favorite).to be_valid
  end

  it 'is invalid without a student' do
    ai_tool = AiTool.create(name: "Test AI Tool")
    favorite = Favorite.new(ai_tool: ai_tool)
    
    expect(favorite).not_to be_valid
  end

  it 'is invalid without an AI tool' do
    student = Student.create(name: "Test Student")
    favorite = Favorite.new(student: student)
    
    expect(favorite).not_to be_valid
  end
  
   #2 Associations
  it { should belong_to(:student) }
  it { should belong_to(:ai_tool) }

   #3 Favorite/Unfavoriting
  it 'does not allow duplicate favorites for the same student and AI tool' do
    student = Student.create(name: "Test Student")
    ai_tool = AiTool.create(name: "Test AI Tool")
    Favorite.create(student: student, ai_tool: ai_tool)
    
    duplicate_favorite = Favorite.new(student: student, ai_tool: ai_tool)
    expect(duplicate_favorite).not_to be_valid
  end
  
   #4 Indexes
  it 'unique index on [student_id, ai_tool_id]' do
    indexes = ActiveRecord::Base.connection.indexes(:favorites)
    unique_index = indexes.detect { |i| i.columns == ['student_id', 'ai_tool_id'] }
    
    expect(unique_index).not_to be_nil
    expect(unique_index.unique).to be(true)
  end
end

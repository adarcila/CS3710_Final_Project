class HomeController < ApplicationController
  # Making Synonyms to broaden search with certain tools
  SYNONYMS = {
    "images" => ["graphics", "pictures", "photos", "art", "creativity", "photo realism", "image"],
    "image" => ["graphics", "pictures", "photos", "art", "creativity", "photo realism"],
    "tool" => ["software", "application", "program"]
  }.freeze

  def index
    if params[:q].present?
      # Split user input into keywords
      keywords = params[:q].split

      # Map keywords to include synonyms
      expanded_keywords = keywords.flat_map do |word|
        SYNONYMS[word.downcase] || [word] # Add synonyms or the original word if no match
      end

      # Prepare the query with LIKE statements for each keyword
      search_terms = expanded_keywords.map { |word| "%#{word.downcase}%" }
      query = search_terms.map do
        "(LOWER(name) LIKE ? OR LOWER(features) LIKE ?)"
      end.join(" OR ")

      query_params = search_terms.flat_map { |word| [word, word] }

      # Execute the search
      @ai_tools = AiTool.where(query, *query_params).distinct
    else
      @ai_tools = []
    end
  end
end

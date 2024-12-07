class AiToolsController < ApplicationController
  before_action :authenticate_student!, only: [:favorite, :unfavorite]

  def index
    @q = AiTool.ransack(params[:q]) # Make sure @q is set for search form
    @ai_tools = @q.result # Fetch the tools based on the Ransack query
    Rails.logger.debug("AI Tools: #{@ai_tools.inspect}") # This will log the content of @ai_tools to the console
  end
  
  def show
    @ai_tool = AiTool.find(params[:id])
  end

  def favorite
    @ai_tool = AiTool.find(params[:id])
    current_student.favorites.create!(ai_tool: @ai_tool)
    redirect_to ai_tool_path(@ai_tool), notice: "AI Tool added to favorites!"
  end

  def unfavorite
    @ai_tool = AiTool.find(params[:id])
    current_student.favorites.find_by(ai_tool: @ai_tool)&.destroy
    redirect_to ai_tool_path(@ai_tool), notice: "AI Tool removed from favorites!"
  end
end
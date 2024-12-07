class FavoritesController < ApplicationController
    before_action :authenticate_student!
  
    def create
      @ai_tool = AiTool.find(params[:ai_tool_id])
      current_student.favorites.create!(ai_tool: @ai_tool)
      redirect_to ai_tool_path(@ai_tool), notice: "AI Tool added to favorites!"
    end
  
    def destroy
      @ai_tool = AiTool.find(params[:ai_tool_id])
      current_student.favorites.find_by(ai_tool: @ai_tool)&.destroy
      redirect_to ai_tool_path(@ai_tool), notice: "AI Tool removed from favorites!"
    end
  end
  
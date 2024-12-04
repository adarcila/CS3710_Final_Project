class AiToolsController < ApplicationController
    def index
      @q = AiTool.ransack(params[:q]) # Make sure @q is set for search form
      @ai_tools = @q.result # Fetch the tools based on the Ransack query
      Rails.logger.debug("AI Tools: #{@ai_tools.inspect}") # This will log the content of @ai_tools to the console
    end
    
    def show
      @ai_tool = AiTool.find(params[:id])
    end
  end
  
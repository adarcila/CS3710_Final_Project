class HomeController < ApplicationController
    def index
      @q = AiTool.ransack(params[:q])
      @ai_tools = @q.result(distinct: true)
    end
  end
  
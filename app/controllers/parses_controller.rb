class ParsesController < ApplicationController
  layout false

  def create
    @parse = Highlighter.perform(parse_params)
  end

  private

  def parse_params
    params.require(:parse).permit(:language, :source)
  end
end

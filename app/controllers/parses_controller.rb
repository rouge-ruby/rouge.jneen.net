class ParsesController < ApplicationController
  layout false

  def create
    @highlighter = Highlighter.new(parse_params)
    @parse = @highlighter.perform
  end

  private

  def parse_params
    params.require(:parse).permit(:language, :source)
  end
end

class ParsesController < ApplicationController
  def create
    render html: Rouge.highlight(parse_params[:source],
                                 parse_params[:language],
                                 'html').html_safe
  end

  private

  def parse_params
    params.require(:parse).permit(:language, :source)
  end
end

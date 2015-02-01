class PastesController < ApplicationController
  layout 'pastes'

  def show
    @paste = Paste.find(params[:id])
    @parse = Highlighter.perform(@paste.attributes)
  end

  def create
    @paste = Paste.new(paste_params)

    if @paste.save
      redirect_to @paste
    else
      flash[:error] = t('flashes.paste.create.error')
      render 'pages/home'
    end
  end

  private

  def paste_params
    params.require(:paste).permit(:language, :source)
  end
end

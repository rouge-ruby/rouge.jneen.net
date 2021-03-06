class PastesController < ApplicationController
  layout 'pastes'

  def show
    @paste = find_paste
  end

  def create
    @paste = Paste.find_or_initialize_by(paste_params)

    if @paste.save
      redirect_to @paste
    else
      flash[:error] = t('flashes.paste.create.error')
      render 'home_pages/show'
    end
  end

  private

  def paste_params
    params.require(:paste).permit(:language, :source)
  end

  def find_paste
    hash = params[:id]
    id = HASHIDS.decode(hash).first
    Paste.find(id)
  end
end

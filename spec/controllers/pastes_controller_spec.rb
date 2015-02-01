require 'rails_helper'

describe PastesController do
  describe '#show' do
    it 'renders a the show view' do
      paste = create(:paste)

      get :show, id: paste.id

      expect(response).to render_template :show
    end

    it 'assigns the paste to @paste' do
      paste = create(:paste)

      get :show, id: paste.id

      expect(assigns[:paste]).to eq(paste)
    end
  end

  describe '#create' do
    context 'valid attributes' do
      it 'creates a paste' do
        expect(Paste.count).to eq(0)

        post :create, paste: attributes_for(:paste)

        expect(Paste.count).to eq(1)
      end

      it 'should redirect to the paste' do
        post :create, paste: attributes_for(:paste)

        expect(response).to redirect_to(assigns[:paste])
      end
    end

    context 'invalid attributes' do
      it 'does not create the paste' do
        expect(Paste.count).to eq(0)

        post :create, paste: { language: :ruby }

        expect(Paste.count).to eq(0)
      end

      it 'redirect to the homepage' do
        post :create, paste: { language: :ruby }

        expect(response).to render_template('pages/home')
      end

      it 'sets the flash error' do
        post :create, paste: { language: :ruby }

        expect(flash[:error]).to eq(t('flashes.paste.create.error'))
      end
    end
  end
end

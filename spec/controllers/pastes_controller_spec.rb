require 'rails_helper'

describe PastesController do
  describe '#show' do
    it 'renders a the show view' do
      paste = create(:paste)

      get :show, id: HASHIDS.encode(paste.id)

      expect(response).to render_template :show
    end

    it 'assigns the paste to @paste' do
      paste = create(:paste)

      get :show, id: HASHIDS.encode(paste.id)

      expect(assigns[:paste]).to eq(paste)
    end

    it 'renders with pastes layout' do
      paste = create(:paste)

      get :show, id: HASHIDS.encode(paste.id)

      expect(response).to render_template(layout: 'pastes')
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

      context 'with the exact same content as another paste' do
        it 'redirects to that paste instead of creating it' do
          paste = create(:paste)
          duplicate_attrs = { language: paste.language, source: paste.source }
          paste_count = Paste.count

          post :create, paste: duplicate_attrs

          expect(assigns[:paste]).to eq(paste)
          expect(Paste.count).to eq(paste_count)
        end
      end
    end

    context 'invalid attributes' do
      it 'does not create the paste' do
        expect(Paste.count).to eq(0)

        post_paste

        expect(Paste.count).to eq(0)
      end

      it 'redirect to the homepage' do
        post_paste

        expect(response).to render_template('home_pages/show')
      end

      it 'sets the flash error' do
        post_paste

        expect(flash[:error]).to eq(t('flashes.paste.create.error'))
      end
    end
  end

  def post_paste
    post :create, paste: { language: :ruby }
  end
end

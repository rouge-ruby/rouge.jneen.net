require 'rails_helper'

describe ParsesController do
  describe '#create' do
    context 'with good input' do
      it 'assigns a html tagged version of the input code to @parse' do
        tagged_ruby = load_fixture 'ruby.html'

        post_parse

        expect(assigns[:parse]).to eq(tagged_ruby)
      end

      it 'renders the :create template' do
        post_parse

        expect(response).to render_template(:create)
      end

      it 'renders with no layout' do
        post_parse

        expect(response).not_to render_template(layout: 'application')
      end
    end

    context 'with trickier newlines' do
      it 'returns a correct markup' do
        tagged_sass = load_fixture('sass.html')

        post_parse(fixture: 'sass.sass', language: :sass)

        expect(assigns[:parse]).to eq(tagged_sass)
      end
    end
  end

  def post_parse(fixture: 'ruby.rb', language: :ruby)
    code = load_fixture(fixture)
    params = { language: language, source: code }

    post :create, parse: params
  end
end

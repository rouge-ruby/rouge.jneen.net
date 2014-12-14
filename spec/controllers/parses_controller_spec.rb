require 'rails_helper'

describe ParsesController do
  describe '#create' do
    it 'assigns a html tagged version of the input code to @parse' do
      tagged_ruby = load_fixture 'ruby_code.html'

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

  def post_parse
    ruby_code = load_fixture 'code.rb'
    params = { language: :ruby, source: ruby_code }

    post :create, parse: params
  end
end

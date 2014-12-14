require 'rails_helper'

describe ParsesController do
  describe '#create' do
    it 'returns a html tagged version of the input code' do
      ruby_code = load_fixture 'code.rb'
      tagged_ruby = load_fixture 'ruby_code.html'
      params = { language: :ruby, source: ruby_code }

      post :create, parse: params

      expect(response.body).to eq(tagged_ruby)
    end
  end
end

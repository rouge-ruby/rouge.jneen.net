require 'rails_helper'

describe Highlighter do
  context 'with good input' do
    it 'highlights the code' do
      tagged_ruby = load_fixture('ruby.html')
      ruby_code = load_fixture('ruby.rb')
      params = { language: 'ruby', source: ruby_code }

      highlighted = Highlighter.perform(params)

      expect(highlighted).to eq(tagged_ruby)
    end
  end

  context 'with tricky input' do
    it 'highlights the code' do
      tagged_sass = load_fixture('sass.html')
      sass_code = load_fixture('sass.sass')
      params = { language: 'sass', source: sass_code }

      highlighted = Highlighter.perform(params)

      expect(highlighted).to eq(tagged_sass)
    end
  end

  context 'with bad input' do
    context 'such as a nonexistant language' do
      it 'raises an error' do
        params = { language: :foo, source: '' }

        expect {
          Highlighter.perform(params)
        }.to raise_error(Highlighter::LexerNotFound)
      end
    end

    context 'such as a nonexistant format' do
      it 'raises an error' do
        params = { language: :ruby, source: '', format: 'foo' }

        expect {
          Highlighter.perform(params)
        }.to raise_error(Highlighter::FormatterNotFound)
      end
    end
  end
end

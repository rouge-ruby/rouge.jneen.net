require 'rails_helper'

describe ApplicationHelper do
  describe '#lexer_options_for_select' do
    it 'returns a hash of languages and values' do
      cpp = Rouge::Lexer.find('cpp')
      option = [cpp.title, cpp.tag]

      lexer_options = helper.lexer_options_for_select

      expect(lexer_options).to be_an(Array)
      expect(lexer_options).to include(option)
    end
  end

  describe '#lexer_count' do
    it 'returns the count of languages available to parse' do
      count = Rouge::Lexer.all.count

      expect(helper.lexer_count).not_to eq(0)
      expect(helper.lexer_count).to eq(count)
    end
  end

  describe '#lexer_title' do
    it 'converts a lexers tag into its title' do
      title = helper.lexer_title('cpp')

      expect(title).to eq('C++')
    end
  end
end

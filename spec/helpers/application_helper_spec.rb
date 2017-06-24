require 'rails_helper'

describe ApplicationHelper do
  let(:rouge) { RougeVersion.current }

  describe '#lexer_options_for_select' do
    it 'returns a hash of languages and values' do
      cpp = rouge::Lexer.find('cpp')
      option = [cpp.title, cpp.tag]

      lexer_options = helper.lexer_options_for_select

      expect(lexer_options).to be_an(Array)
      expect(lexer_options).to include(option)
    end
  end

  describe '#lexer_count' do
    it 'returns the count of languages available to parse' do
      count = rouge::Lexer.all.count

      expect(helper.lexer_count).not_to eq(0)
      expect(helper.lexer_count).to eq(count)
    end
  end
end

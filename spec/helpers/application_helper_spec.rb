require 'rails_helper'

describe ApplicationHelper do
  describe '#lexer_options_for_select' do
    it 'returns a hash of languages and values' do
      first_lexer = ['AppleScript', 'applescript']

      lexer_options = helper.lexer_options_for_select

      expect(lexer_options).to be_an(Array)
      expect(lexer_options.first).to eq(first_lexer)
    end
  end

  describe '#lexer_count' do
    it 'returns the count of languages available to parse' do
      count = Rouge::Lexer.all.count

      expect(helper.lexer_count).not_to eq(0)
      expect(helper.lexer_count).to eq(count)
    end
  end
end

require 'rails_helper'

describe ApplicationHelper do
  describe '#lexer_options_for_select' do
    it 'returns a hash of languages and values' do
      first_lexer = ['AppleScript', 0]

      lexer_options = helper.lexer_options_for_select

      expect(lexer_options).to be_an(Array)
      expect(lexer_options.first).to eq(first_lexer)
    end
  end
end

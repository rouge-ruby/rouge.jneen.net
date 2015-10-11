require 'rails_helper'

describe Paste do
  describe 'validations' do
    it { should validate_presence_of :language }
    it { is_expected.to validate_presence_of(:source) }
  end

  describe '#to_param' do
    it 'returns the hash_id instead of the id' do
      hash = 'abc'
      allow(HASHIDS).to receive(:encode).and_return(hash)
      paste = create(:paste)

      expect(paste.to_param).to eq(hash)
    end
  end

  describe '#lexer' do
    it 'fetches the lexer based on the language' do
      paste = create(:paste, :language => 'cpp')
      expect(paste.lexer.tag).to eql('cpp')
    end
  end
end

require 'rails_helper'

describe Paste do
  describe 'validations' do
    it { should validate_presence_of :language }
    it { should validate_presence_of :source }
  end
end

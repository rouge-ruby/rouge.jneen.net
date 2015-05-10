class Paste < ActiveRecord::Base
  validates_presence_of :language
  validates_presence_of :source

  def to_param
    HASHIDS.encode(id)
  end

  def lexer
    Rouge::Lexer.find(self.language)
  end

  def parse
    Highlighter.perform(self.attributes)
  end

  def self.demo_for(lexer)
    new do |paste|
      paste.language = lexer.tag
      paste.source = lexer.demo
    end
  end
end

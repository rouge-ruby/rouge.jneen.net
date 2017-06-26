class Paste < ActiveRecord::Base
  validates_presence_of :language
  validates_presence_of :source

  def to_param
    HASHIDS.encode(id)
  end

  def lexer
    @lexer ||= RougeVersion.current::Lexer.find(self.language)
  end

  def lexer_title
    lexer.respond_to?(:title) ? lexer.title : lexer.tag
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

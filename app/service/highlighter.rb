class Highlighter
  class FormatterNotFound < StandardError; end
  class LexerNotFound < StandardError; end

  def initialize(params)
    @params = params.with_indifferent_access
  end

  def self.perform(params)
    new(params).perform
  end

  def perform
    formatter.format(lexer.lex(source)).html_safe
  end

  private

  def source
    @source ||= @params[:source].encode(universal_newline: true)
  end

  def rouge
    RougeVersion.current
  end

  def lexer
    if @lexer ||= rouge::Lexer.find(@params[:language])
      @lexer
    else
      raise LexerNotFound, I18n.t('errors.highlighter.lexer_not_found')
    end
  end

  def formatter
    @formatter ||= rouge::Formatters::HTML.new(wrap: false)
  end
end

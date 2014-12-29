class Highlighter
  class FormatterNotFound < StandardError; end
  class LexerNotFound < StandardError; end

  def initialize(params)
    opts = { format: 'html' }
    @params = opts.merge(params.symbolize_keys)
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

  def lexer
    if @lexer ||= Rouge::Lexer.find(@params[:language])
      @lexer
    else
      raise LexerNotFound, I18n.t('errors.highlighter.lexer_not_found')
    end
  end

  def formatter
    if @formatter ||= Rouge::Formatter.find(@params[:format])
      @formatter.new(wrap: false)
    else
      raise FormatterNotFound, I18n.t('errors.highlighter.formatter_not_found')
    end
  end
end

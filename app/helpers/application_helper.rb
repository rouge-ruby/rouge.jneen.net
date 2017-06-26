module ApplicationHelper
  def rouge
    RougeVersion.current
  end

  def all_lexers
    rouge::Lexer.all.sort_by(&:tag)
  end

  def lexer_options_for_select
    all_lexers.map do |lexer|
      [lexer_title(lexer), lexer.tag]
    end
  end

  def lexer_title(lexer)
    lexer.respond_to?(:title) ? lexer.title : lexer.tag
  end

  def lexer_count
    all_lexers.count
  end
end

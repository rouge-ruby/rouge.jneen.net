module ApplicationHelper
  def all_lexers
    Rouge::Lexer.all.sort_by(&:tag)
  end

  def lexer_options_for_select
    all_lexers.map do |lexer|
      [lexer.title, lexer.tag]
    end
  end

  def lexer_count
    all_lexers.count
  end

  def lexer_title(tag)
    lexer = Rouge::Lexer.find(tag)
    lexer.title
  end
end

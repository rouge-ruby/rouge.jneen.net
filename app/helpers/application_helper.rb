module ApplicationHelper
  def lexer_options_for_select
    Rouge::Lexer.all.map do |lexer|
      [lexer.title, lexer.tag]
    end
  end

  def lexer_count
    Rouge::Lexer.all.count
  end
end

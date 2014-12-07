module ApplicationHelper
  def lexer_options_for_select
    Rouge::Lexer.all.map do |lexer|
      [lexer.name.demodulize, lexer.tag]
    end
  end
end

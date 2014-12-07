module ApplicationHelper
  def lexer_options_for_select
    Rouge::Lexer.all.each_with_index.map do |lexer, i|
      [lexer.name.demodulize, i]
    end
  end
end

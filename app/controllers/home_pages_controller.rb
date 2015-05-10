class HomePagesController < ApplicationController
  def show
    lexer = Rouge::Lexer.all.sample
    @demo = Paste.demo_for(lexer)
  end
end

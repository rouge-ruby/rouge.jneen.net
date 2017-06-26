class HomePagesController < ApplicationController
  def show
    lexer = rouge::Lexer.all.sample
    @demo = Paste.demo_for(lexer)
  end
end

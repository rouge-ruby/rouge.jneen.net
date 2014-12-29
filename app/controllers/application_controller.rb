class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  [Highlighter::LexerNotFound,
   Highlighter::FormatterNotFound].each do |highlighter_error|
    rescue_from highlighter_error do |exception|
      @parse = "<span class='err'>Error: #{exception.message}</span>".html_safe
      render 'parses/create'
    end
  end
end

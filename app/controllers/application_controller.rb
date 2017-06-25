class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :detect_rouge_version

  [Highlighter::LexerNotFound,
   Highlighter::FormatterNotFound].each do |highlighter_error|
    rescue_from highlighter_error do |exception|
      @parse = "<span class='err'>Error: #{exception.message}</span>".html_safe
      render 'parses/create'
    end
  end

  def detect_rouge_version
    version = params[:rouge_version]&.strip
    return yield unless version
    return yield unless version =~ /\A\d+[.]\d+[.]\d+\z/
    return yield unless RougeVersion.version(params[:rouge_version])

    RougeVersion.with_version(params[:rouge_version]) { yield }
  end

  def rouge
    RougeVersion.current
  end
end

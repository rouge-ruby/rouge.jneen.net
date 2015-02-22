if Rails.env.development?
  namespace :dev do
    desc 'Seed data for development environment'
    task prime: 'db:setup' do
      PUBLIC_GISTS_URL = 'https://api.github.com/gists/public'
      GITHUB_API_HEADERS = { 'Accept' => 'application/vnd.github.v3+json' }

      gists = fetch_all_gists

      gists.each do |gist|
        Gist.new(gist).create_pastes!
      end
    end

    def fetch_all_gists
      response = HTTParty.get(PUBLIC_GISTS_URL, GITHUB_API_HEADERS)
      JSON.parse(response.body)
    end

    class Gist
      attr_accessor :files

      def initialize(json)
        @json = json
        create_files
      end

      def create_pastes!
        @files.each(&:create_paste!)
      end

      private

      def create_files
        @files = []
        @json['files'].each do |file|
          @files << GistFile.new(file)
        end
      end
    end

    class GistFile
      attr_accessor :language, :url

      def initialize(json)
        attributes = json.last
        @language = attributes['language']
        @url = attributes['raw_url']
      end

      def data
        response = HTTParty.get(@url)
        response.body
      end

      def create_paste!
        if valid?
          Paste.create(language: language, source: data)
        end
      end

      def language
        if @language.present?
          @language.downcase
        end
      end

      def valid?
        lexer.present?
      end

      def lexer
        if language.present?
          Rouge::Lexer.find(language)
        end
      end
    end
  end
end

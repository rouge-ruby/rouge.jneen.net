require 'thread'

module RougeVersion
  class << self
    TMP_DIR = Pathname.new(ENV['ROUGE_VERSION_TMP'] || Rails.root.join('tmp/rouge-versions'))
    LOAD_MUTEX = Mutex.new

    Bundler.mkdir_p(TMP_DIR)

    def available_versions_file
      TMP_DIR.join('available_versions')
    end

    def fetch_available_versions
      response = `gem query --versions --all -r -e rouge`

      response =~ /rouge\s*[(](.*?)[)]/

      return nil unless $1

      versions = $1.split(/,\s*/).reverse

      available_versions_file.open('w') { |f| f.puts versions }

      versions
    end

    def available_versions
      if available_versions_file.exist? and Time.now - available_versions_file.mtime <= 1.day
        return available_versions_file.readlines.map(&:chomp)
      end

      fetch_available_versions
    end

    def versions_cache
      @versions_cache ||= {}
    end

    def version(version_number)
      versions_cache[version_number] ||= load_version(version_number)
    end

    def with_version(version_number)
      t = Thread.current
      k = :'RougeVersion.current'

      t[k], old = version_number, t[k]
      yield
    ensure
      t[k] = old
    end

    def current
      version(Thread.current[:'RougeVersion.current'] || available_versions.last)
    end

    def load_version(version_number)
      version_dir = TMP_DIR.join("rouge-#{version_number}")
      fetch_version(version_number) unless version_dir.exist?

      LOAD_MUTEX.synchronize do
        # clean up just in case
        Object.send(:remove_const, :Rouge) rescue NameError

        Kernel.load(version_dir.join('lib/rouge.rb'))

        # These need to be preloaded while the correct `Rouge` is in the global scope,
        # because they assume the existence of a global `Rouge` object. In the future
        # we'll handle these differently (i.e. with a yaml file, like the Apache lexer),
        # so it won't be necessary to add to this list.
        #
        # The `rescue`s are for the cases where the lexer isn't defined in the current
        # version.
        Rouge::Lexers::Lua.builtins rescue nil
        Rouge::Lexers::PHP.builtins rescue nil
        Rouge::Lexers::VimL.keywords rescue nil
        Rouge::Lexers::Gherkin.builtins rescue nil
        Rouge::Lexers::Matlab.builtins rescue nil

        # override for when the `Rouge` constant is looked up from within
        # the Rouge namespace - the default behavior is to look it up globally.
        Rouge.const_set(:Rouge, Rouge)

        # removes the constant from the global scope and returns the value
        Object.send(:remove_const, :Rouge)
      end
    end

    def fetch_version(version_number)
      Dir.chdir(TMP_DIR) do
        system "gem fetch rouge -v #{version_number}"
        system "gem unpack rouge-#{version_number}.gem"
      end
    end
  end
end

namespace :rouge do
  task :precache => :precache_available do
    require "#{Rails.root}/app/models/rouge_version.rb"

    RougeVersion.fetch_available_versions.each do |version|
      # no prerelease versions
      next if version =~ /^0[.]/

      # fetches if not already on disk
      puts "fetching #{version}..."
      begin
        RougeVersion.load_version(version)
      rescue LoadError => e
        puts e.to_s
      end

      puts "done"
    end
  end

  task :precache_available do
    require "#{Rails.root}/app/models/rouge_version.rb"

    RougeVersion.fetch_available_versions
  end
end

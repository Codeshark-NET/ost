require 'csv'

namespace :projects do
  desc 'sync projects'
  task :sync => :environment do
    Project.sync_least_recently_synced
  end

  desc 'import projects'
  task :import => :environment do
    Project.import_from_readme
  end

  desc 'discover projects'
  task :discover => :environment do
    Project.discover_via_topics
  end
end
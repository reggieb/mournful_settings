require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rdoc/task'
require 'rake/testtask'
require 'logger'

Rake::RDocTask.new do |rdoc|
  files =['README.rdoc', 'MIT-LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README.rdoc" # page to start on
  rdoc.title = "Dibber Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

namespace :mournful_settings do
  
  namespace :db do
    task :environment do
      require 'active_record'
      environment = ENV['RAILS_ENV'] || 'development'
      ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database =>  "test/dummy/db/#{environment}.sqlite3.db"
    end

    desc "Migrate the database"
    task(:migrate => :environment) do
      ActiveRecord::Migrator.migrate("db/migrate", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    end

    desc "Roll back the database"
    task(:rollback => :environment) do
      ActiveRecord::Migrator.rollback("db/migrate")
    end
  end
  
end

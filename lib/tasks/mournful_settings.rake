namespace :mournful_settings do

  desc 'Outputs a mournful test message'
  task(:task_test => :environment) do
    puts "Able to access mournful tasks located at #{File.dirname(__FILE__)}"
  end
  
  namespace :install do
    # TODO - register within 'rake railties:install:migrations'
    desc 'Copies mournful_settings migrations to host rails app'
    task(:migrations => :environment) do
      mournful_migrate_path = File.expand_path("../../db/migrate", File.dirname(__FILE__)) 
      rails_migrate_path = File.expand_path("db/migrate", Rails.root)
      scope = :mournful_settings
      migration = ActiveRecord::Migration.new
      output = migration.copy rails_migrate_path, {scope => mournful_migrate_path}
      if output.empty?
        puts "No migrations copied to #{rails_migrate_path}"
      else
        puts "Migrations created at #{rails_migrate_path}:"
        files = output.collect{|m| m.filename.sub rails_migrate_path, ""}
        files.each{|m| puts "\t#{m}"}
      end
    end
  end
  
  
end
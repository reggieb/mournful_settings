namespace :mournful_settings do

  desc 'Outputs a mournful test message'
  task(:task_test => :environment) do
    puts "Able to access mournful tasks located at #{File.dirname(__FILE__)}"
  end
end
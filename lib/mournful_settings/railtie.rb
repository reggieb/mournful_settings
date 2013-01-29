require 'mournful_settings'
require 'rails'
module MournfulSettings
  class Railtie < Rails::Railtie
    # makes mournful_settings rake tasks available to host app
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'../tasks/*.rake')].each { |f| load f }
    end 
    
  end
end

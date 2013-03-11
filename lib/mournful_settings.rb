require 'active_record'
require_relative 'mournful_settings/setting'
require_relative "mournful_settings/railtie" if defined?(Rails) # needed for rake tasks to be loaded into host app
require_relative 'active_record/acts/mournful_setting'

module MournfulSettings
  
  def self.active_admin_load_path
    File.expand_path("active_admin/admin", File.dirname(__FILE__))
  end
    
end

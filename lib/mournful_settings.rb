require 'active_record'
require_relative "mournful_settings/railtie" if defined?(Rails) # needed for rake tasks to be loaded into host app
require_relative 'active_record/acts/mournful_setting'
require_relative 'mournful_settings/setting'
require 'logger'

module MournfulSettings
  
  def self.active_admin_load_path
    File.expand_path("active_admin/admin", File.dirname(__FILE__))
  end

  def self.logger
    defined?(Rails) ? Rails.logger : local_logger
  end

  def self.logger=(alternative_logger)
    @logger = alternative_logger
  end

  def self.local_logger
    @logger ||= Logger.new('log/mournful_settings.log')
  end
    
end

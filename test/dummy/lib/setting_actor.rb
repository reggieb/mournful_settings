require_relative '../../../lib/mournful_settings'

class SettingActor < ActiveRecord::Base
  
  self.table_name = 'mournful_settings_settings'
  
  acts_as_mournful_setting
  
end

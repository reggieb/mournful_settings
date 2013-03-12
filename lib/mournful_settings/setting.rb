module MournfulSettings
  class Setting < ActiveRecord::Base
    
    self.table_name = 'mournful_settings_settings'
       
    acts_as_mournful_setting
    
  end
end

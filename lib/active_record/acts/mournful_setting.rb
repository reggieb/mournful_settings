require 'mournful_settings/setting_methods'
module ActiveRecord
  module Acts
    module MournfulSetting
           
      def self.included(base)
        base.send :extend, ClassMethods
      end
      
      module ClassMethods
        def acts_as_mournful_setting
          include MournfulSettings::SettingMethods
          extend MournfulSettings::SettingMethods::ClassMethods
        end
        
      end
      
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::MournfulSetting)
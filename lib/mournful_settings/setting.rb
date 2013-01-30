require 'base64'
module MournfulSettings
  class Setting < ActiveRecord::Base
    
    self.table_name = 'mournful_settings_settings'
       
    VALUE_TYPES = ['text', 'number', 'decimal']
    
    before_save :encrypt_text

    validates :value_type, :presence => true, :inclusion => {:in => VALUE_TYPES}
    validates :value, :presence => true
    validates :name, :uniqueness => true, :presence => true

    def self.value_types
      VALUE_TYPES
    end
    
    def self.for(name)
      setting = find_by_name(name)
      setting.value if setting
    end

    def value
      if value_type.present? 
        parent_value = encrypted? ? decrypt(super) : super
        
        case value_type.to_s
          when 'number'
            parent_value.to_f
          when 'decimal'
            BigDecimal.new(parent_value.to_s)
          else
            parent_value
        end
      end
    end
    
    private
    def encrypt(text)
      Base64.encode64 text.to_s
    end
    
    def decrypt(text)
      if is_encrypted?(text)
        Base64.decode64 text
      else
        text
      end
    end
    
    def is_encrypted?(text)
      return false unless text.kind_of? String
      letters_and_number_with_equal_sign_packing = /^\w+=*/
      last_bit = text.getbyte(-1)
      line_feed = 10
      
      last_bit == line_feed and letters_and_number_with_equal_sign_packing =~ text
    end
    
    def encrypt_text    
      self.value = encrypt(self.value) if encrypted?
    end
    
  end
end

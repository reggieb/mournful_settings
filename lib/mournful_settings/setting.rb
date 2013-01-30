require 'base64'
module MournfulSettings
  class Setting < ActiveRecord::Base
    
    self.table_name = 'mournful_settings_settings'
       
    ENCRYPTION_TYPE = 'encrypt'
    VALUE_TYPES = ['text', 'number', 'decimal', ENCRYPTION_TYPE]
    
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
        case value_type.to_s
          when 'number'
            super.to_f
          when 'decimal'
            BigDecimal.new(super.to_s)
          when ENCRYPTION_TYPE
            decrypt super
          else
            super
        end
      end
    end
    
    private
    def encrypt(text)
      Base64.encode64 text
    end
    
    def decrypt(text)
      if is_encrypted?(text)
        Base64.decode64 text
      else
        text
      end
    end
    
    def is_encrypted?(text)
      letters_and_number_with_equal_sign_packing = /^\w+=*/
      last_bit = text.getbyte(-1)
      line_feed = 10
      
      last_bit == line_feed and letters_and_number_with_equal_sign_packing =~ text
    end
    
    def encrypt_text    
      self.value = encrypt(self.value) if self.value_type == ENCRYPTION_TYPE
    end
    
  end
end

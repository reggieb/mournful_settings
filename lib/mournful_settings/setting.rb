require 'base64'
require_relative 'setting/cipher'
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
      add_separators Base64.encode64 Cipher.encrypt text.to_s
    end
    
    def decrypt(text)
      if is_encrypted?(text)
        Cipher.decrypt Base64.decode64 remove_separators text
      else
        text
      end
    end
    
    def is_encrypted?(text)
      inside_separators_and_is_base64_encoded?(text)
    end

    def inside_separators_and_is_base64_encoded?(text)
      return false unless text.kind_of? String
      elements = {
        :starts_with_separator => "^#{separator}",
        :non_white_space_with_equal_sign_packing => '\S+=*',
        :base64_end => "\n",
        :ends_with_separator => "#{separator}$"
      }
      pattern = elements.values.join
      /#{pattern}/ =~ text      
    end
    
    def is_separator_delimited(text)
      
    end
    
    def encrypt_text  
      if encrypted?
        self.value = encrypt(self.value)
      else
        self.value = decrypt(self.value)
      end
    end
    
    def add_separators(text)
      [separator, text, separator].join
    end
    
    def remove_separators(text)
      text.gsub(separator, "")
    end
    
    def separator
      31.chr # ASCII unit separator
    end
    
  end
end

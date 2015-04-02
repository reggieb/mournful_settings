require 'base64'
require_relative 'setting_methods/cipher'
module MournfulSettings
  module SettingMethods 
    
    VALUE_TYPES = ['text', 'number', 'decimal']
       
    def self.included(base)
      base.before_save :set_encrypted_true_unless_false
      base.before_save :encrypt_value

      base.validates :value_type, :presence => true, :inclusion => {:in => VALUE_TYPES}
      base.validates :value, :presence => true
      base.validates :name, :uniqueness => true, :presence => true
    end
    
    module ClassMethods
      def value_types
        VALUE_TYPES
      end

      def for(name, default = nil)
        setting = find_by_name(name.to_s)  # values should be passed to AR as strings
        MournfulSettings.logger.debug "MornfulSetting for #{name} called"
        setting ? setting.value : default
      rescue ActiveRecord::StatementInvalid => e
        MournfulSettings.logger.warn "Default MournfulSetting for '#{name}' forced because: #{e.message}"
        return default
      end
      
      def recrypt_all &do_while_unencrypted
        encrypted = where(:encrypted => true)
        encrypted.each {|s| s.encrypted = false; s.save}
        do_while_unencrypted.call if do_while_unencrypted
        encrypted.each {|s| s.encrypted = true; s.save}
      end
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
      return unless text.kind_of? String
      bytes = text.bytes.to_a
      return unless bytes[0] == separator_byte
      return unless bytes[-1] == separator_byte
      return unless bytes[-2] == last_byte_of_base_64_encoded_text
      non_white_space_with_equal_sign_packing =~ text[1..-3]
    end
    
    def non_white_space_with_equal_sign_packing 
      /\S+=*/
    end
    
    def set_encrypted_true_unless_false
      self.encrypted = true unless self.encrypted == false
    end

    
    def encrypt_value  
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
   
    # Used to delimit encrypted values to make identification more reliable
    def separator
      separator_byte.chr 
    end
    
    
    def separator_byte
      31 # ASCII unit separator
    end
    
    def last_byte_of_base_64_encoded_text
      line_feed_byte
    end
    
    def line_feed_byte
      10
    end
    
  end
end

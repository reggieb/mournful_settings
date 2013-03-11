module MournfulSettings
  module SettingMethods 

    # Based on http://philtoland.com/post/807114394/simple-blowfish-encryption-with-ruby
    module Cipher
      def self.cipher(mode, data)
        cipher = OpenSSL::Cipher::Cipher.new(config).send(mode)
        cipher.key = Digest::SHA256.digest(key)
        cipher.update(data) << cipher.final
      end

      def self.encrypt(data)
        cipher(:encrypt, data)
      end

      def self.decrypt(text)
        cipher(:decrypt, text)
      end
      
      def self.key=(text)
        @key = text
      end
      
      def self.key
        @key ||= 'Set your own with Setting::Cipher.key = your_key'
      end
      
      def self.config=(text)
        raise "'#{text}' is not a value cipher" unless OpenSSL::Cipher::Cipher.ciphers.include?(text)
        @config = text 
      end
      
      def self.config
        @config ||= blowfish_cipher
      end
      
      def self.blowfish_cipher
        'bf-cbc' 
      end
    end
    
  end
end
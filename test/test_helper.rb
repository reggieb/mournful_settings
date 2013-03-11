$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$:.unshift File.join(File.dirname(__FILE__),'dummy','lib')

require 'test/unit'

require 'active_record'
ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database =>  "test/dummy/db/test.sqlite3.db"

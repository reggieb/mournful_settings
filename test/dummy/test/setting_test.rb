require_relative '../../test_helper'

class SettingTest < Test::Unit::TestCase
  
  def setup
    @setting = Setting.create(:name => 'test', :value => 'foo', :value_type => 'text')
  end
  
  def test_inheritence
    assert_kind_of(MournfulSettings::Setting, @setting)   
  end
  
  
end

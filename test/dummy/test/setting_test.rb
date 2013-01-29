require_relative '../../test_helper'

class SettingTest < Test::Unit::TestCase
  
  def setup
      
  end
  
  def teardown
    Setting.delete_all
  end
  
  def test_inheritence
    assert_kind_of(MournfulSettings::Setting, text_setting)   
  end
  
  def test_number_value
    assert_kind_of(Float, number_setting.value)
  end

  def test_text_value
    assert_kind_of(String, text_setting.value)
  end

  def test_decimal_value
    assert_kind_of(BigDecimal, decimal_setting.value)
  end

  def test_valid_types
    Setting::VALUE_TYPES.each do |valid_type|
      number_setting.value_type = valid_type
      assert(number_setting.valid?, "number_setting should be valid when value_type = #{valid_type}")
    end
  end

  def test_invalid_type
    number_setting.value_type = 'invalid'
    assert(number_setting.invalid?, "number_setting should be invalid")
  end

  def test_for
    [number_setting, text_setting, decimal_setting].each do |setting|
      assert_equal(setting.value, Setting.for(setting.name.to_sym))
    end
  end

  def test_for_when_no_matching_setting
    assert_nil(Setting.for(:nothing), "Should return nil when setting doesn't exist")
  end
  
  private
  def text_setting 
    @text_setting ||= Setting.create(:name => 'text_setting', :value => 'foo', :value_type => 'text')
  end
  
  def number_setting
    @number_setting ||= Setting.create(:name => 'number_setting', :value => '1.33333333333333', :value_type => 'number')    
  end
  
  def decimal_setting
    @decimal_setting ||= Setting.create(:name => 'decimal_setting', :value => '4.55', :value_type => 'decimal')    
  end
  
  
end

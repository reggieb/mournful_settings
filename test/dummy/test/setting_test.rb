require_relative '../../test_helper'

class SettingTest < Test::Unit::TestCase
  
  def setup
    @value = 'A secret'
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
  
  def test_encrypted_value
    assert_kind_of(String, encrypted_setting.value)
    assert_equal(@value, encrypted_setting.value)
  end
  
  def test_encrypted_value_is_encrypted_in_database
    database_value = database_value_for(encrypted_setting)
    assert_not_equal(database_value, encrypted_setting.value)
  end
  
  def test_encrypted_with_different_value_types
    {
      'text' => 'this is a load of text',
      'number' => 1.33333333,
      'decimal' => 1.44
    }.each do |value_type, value|
      setting = Setting.create(:name => value_type, :value => value, :value_type => value_type, :encrypted => true)
      assert_equal(value, setting.value)
      assert_not_equal(database_value_for(setting), setting.value)
      assert_not_equal(database_value_for(setting).to_s, setting.value.to_s)
    end
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
    [number_setting, text_setting, decimal_setting, encrypted_setting].each do |setting|
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
  
  def encrypted_setting
    @encrypted_setting ||= Setting.create(:name => 'encrypted_setting', :value => @value, :value_type => 'text', :encrypted => true)
  end
  
  def database_value_for(setting)
    sql = "SELECT value FROM mournful_settings_settings WHERE id = #{setting.id}"
    Setting.connection.select_value(sql)
  end
  
  
end

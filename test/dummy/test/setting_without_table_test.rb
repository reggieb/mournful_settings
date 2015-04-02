require_relative '../../test_helper'
require 'setting_without_table'

# If an application is moved to a new location and settings are used in the
# application configuration, it is impossible to create the Settings table
# via the normal rake tasks if MournfulSetting.for returns a
# 'Could not find table' error. That leave the app in the loop - need a
# settings table to start the app, but can't create the tables without starting
# the app.
#
# So MournfulSetting.for needs to be handle the lack of table.
#
class SettingWithoutTableTest < Test::Unit::TestCase

  def test_for_without_default
    assert_equal nil, SettingWithoutTable.for(:foo)
  end

  def test_for_with_default
    default = 'bar'
    assert_equal default, SettingWithoutTable.for(:foo, default)
  end

end

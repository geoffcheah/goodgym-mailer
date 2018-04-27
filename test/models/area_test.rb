require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  test "should not save area without a name" do
    area = Area.new
    refute area.valid?, "area is valid without a name"
    assert_not_nil area.errors[:name], "no validation error for name present"
  end
end

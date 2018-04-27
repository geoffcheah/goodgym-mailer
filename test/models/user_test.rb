require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not create user without first name" do
    user = User.new(email: "gc@gmail.com", password: "123456", last_name: "cheah", area: Area.new(name: "Camden"))
    refute user.valid?, "user is valid without first_name"
    assert_not_nil user.errors[:first_name], "no validation error for first_name present"
  end

  test "should not create user without last name" do
    user = User.new(email: "gc@gmail.com", password: "123456", first_name: "geo", area: Area.new(name: "Islington"))
    refute user.valid?, "user is valid without last_name"
    assert_not_nil user.errors[:last_name], "no validation error for last_name present"
  end

  test "should belong to an area" do
    user = User.new(email: "gc@gmail.com", password: "123456", first_name: "ge", last_name: "cheah")
    refute user.valid?, "user is valid without area"
    assert_not_nil user.errors[:area], "no validation error for area present"
    assert_not user.area, "User needs to belong to an area"
  end

  test "should not save area without a name" do
    area = Area.new
    assert_not area.save, "An area cannot be created and saved without a name"
  end
end

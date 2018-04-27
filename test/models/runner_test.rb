require 'test_helper'

class RunnerTest < ActiveSupport::TestCase
  test "should not create runner without first name" do
    runner = Runner.new(email: "gc@gmail.com", last_name: "cheah", area: Area.new(name: "Camden"), status: "lapsed")
    refute runner.valid?, "runner is valid without first_name"
    assert_not_nil runner.errors[:first_name], "no validation error for first_name present"
  end

  test "should not create runner without last name" do
    runner = Runner.new(email: "gc@gmail.com", first_name: "geo", area: Area.new(name: "Islington"), status: "lapsed")
    refute runner.valid?, "Runner is valid without last_name"
    assert_not_nil runner.errors[:last_name], "no validation error for last_name present"
  end

  test "should belong to an area" do
    runner = Runner.new(email: "gc@gmail.com", first_name: "ge", last_name: "cheah", status: "lapsed")
    refute runner.valid?, "runner is valid without area"
    assert_not_nil runner.errors[:area], "no validation error for area present"
    assert_not runner.area, "Runner needs to belong to an area"
  end

  test "runner should have a status" do
    runner = Runner.new(email: "gc@gmail.com", first_name: "ge", last_name: "cheah", area: Area.new(name: "Islington"))
    refute runner.valid?, "runner is valid without status"
    assert_not_nil runner.errors[:status], "no validation error for status present"

  end

  test "runner should have correct status" do
    runner = Runner.new(email: "gc@gmail.com", first_name: "ge", last_name: "cheah", area: Area.new(name: "Islington"), status: "happy")
    refute runner.valid?, "runner is valid without status being lapsed, never_run or regular"
    assert_not_nil runner.errors[:status], "no validation error for correct status present"
  end

  test "runner should have a email" do
    runner = Runner.new(first_name: "ge", last_name: "cheah", area: Area.new(name: "Islington"), status: "never_run")
    refute runner.valid?, "runner is valid without email"
    assert_not_nil runner.errors[:email], "no validation error for email present"
  end
end

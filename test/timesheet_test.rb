require './test/test_helper'
require './lib/timesheet'

class TimesheetTest < Minitest::Test
  def setup
    @timesheet = Timesheet.new('5', '7', '2015-01-01', '120')
  end

  def test_instantiation
    assert_instance_of Timesheet, @timesheet
  end

  def test_attributes
    assert_instance_of Integer, @timesheet.employee_id
    assert_equal 5, @timesheet.employee_id
    assert_instance_of Integer, @timesheet.project_id
    assert_equal 7, @timesheet.project_id
    assert_equal '2015-01-01', @timesheet.date
    assert_instance_of Integer, @timesheet.minutes
    assert_equal 120, @timesheet.minutes
  end
end

require './test/test_helper'
require './lib/company'
require 'csv'

class CompanyTest < Minitest::Test
  def setup
    @company = Company.new
  end

  def test_instantiation
    assert_instance_of Company, @company
  end

  def test_attributes
    assert_instance_of Array, @company.employees
    assert_instance_of Array, @company.projects
    assert_instance_of Array, @company.timesheets
  end

  def test_valid_employee_csv_hash_creation
    @company.load_employee_file('./data/employees.csv')
    assert_equal true, @company.employees[0][:success]
  end

  def test_invalid_employee_csv_hash_creation
    @company.load_employee_file('./data/bad_employees.csv')
    assert_equal false, @company.employees[1][:success]
  end

  def test_employee_csv_hash_creation
    @company.load_employee_file('./data/employees.csv')
    refute_equal [], @company.employees
    assert_equal 'Susan Smith', @company.employees[0][:employee].name
    assert_equal 'Engineer', @company.employees[1][:employee].role
    assert_equal '2016-01-01', @company.employees[0][:employee].start_date
    assert_equal '2018-02-20', @company.employees[1][:employee].end_date
  end

  def test_valid_project_csv_hash_creation
    @company.load_project_file('./data/projects.csv')
    assert_equal true, @company.projects[0][:success]
  end

  def test_invalid_project_csv_hash_creation
    @company.load_project_file('./data/bad_projects.csv')
    assert_equal false, @company.projects[1][:success]
  end

  def test_project_csv_hash_creation
    @company.load_project_file('./data/projects.csv')
    refute_equal [], @company.projects
    assert_equal 'Widgets', @company.projects[0][:project].name
    assert_equal '2016-12-01', @company.projects[1][:project].start_date
    assert_equal '2018-01-28', @company.projects[2][:project].end_date
  end

  def test_valid_timesheet_csv_hash_creation
    @company.load_timesheet_file('./data/timesheets.csv')
    assert_equal true, @company.timesheets[0][:success]
  end

  def test_invalid_timesheet_csv_hash_creation
    @company.load_timesheet_file('./data/bad_timesheets.csv')
    assert_equal false, @company.timesheets[7][:success]
  end

  def test_timesheet_csv_hash_creation
    @company.load_timesheet_file('./data/timesheets.csv')
    refute_equal [], @company.timesheets
    assert_equal 1, @company.timesheets[0][:timesheet].employee_id
    assert_equal 1, @company.timesheets[1][:timesheet].project_id
    assert_equal '2016-01-02', @company.timesheets[2][:timesheet].date
    assert_equal 480, @company.timesheets[2][:timesheet].minutes
  end

  def test_find_employee_by_id
    @company.load_employee_file('./data/employees.csv')
    assert_equal 'Susan Smith', @company.find_employee_by_id(1)[:employee].name
    assert_nil @company.find_employee_by_id(4)
  end

  def test_find_project_by_id
    @company.load_project_file('./data/projects.csv')
    assert_equal 'Widgets', @company.find_project_by_id(1)[:project].name
    assert_nil @company.find_project_by_id(6)
  end
end

require 'csv'
class Company
  attr_reader :employees,
              :projects,
              :timesheets
  def initialize
    @employees  = []
    @projects   = []
    @timesheets = []
  end

  def load_employee_file(csv_file)
    lines = CSV.read(csv_file)
    lines.map do |line|
      if employee_valid?(line)
        @employees << (employee_good_data(line))
      else
        @employees << (bad_data)
      end
    end
  end

  def load_project_file(csv_file)
    lines = CSV.read(csv_file)
    lines.map do |line|
      if project_valid?(line)
        @projects << (project_good_data(line))
      else
        @projects << (bad_data)
      end
    end
  end

  def load_timesheet_file(csv_file)
    lines = CSV.read(csv_file)
    lines.map do |line|
      if timesheet_valid?(line)
        @timesheets << (timesheet_good_data(line))
      else
        @timesheets << (bad_data)
      end
    end
  end

  def data_check(valid, data_type)
    if valid == true
      data_type
    else
      bad_data
    end
  end

  def load_employees(elements)
    elements.map do |element|
      @employees << employee_good_data(element)
    end
  end

  def load_projects(elements)
    elements.map do |element|
      @project << project_good_data(element)
    end
  end

  def load_timesheets(elements)
    elements.map do |element|
      @timesheets << timesheet_good_data(element)
    end
  end

  def employee_good_data(element)
    id          = element[0]
    name        = element[1]
    role        = element[2]
    start_date  = element[3]
    end_date    = element[4]
    { success: true,
      error: nil,
      employee: Employee.new(id, name, role, start_date, end_date) }
  end

  def project_good_data(element)
    id          = element[0]
    name        = element[1]
    start_date  = element[2]
    end_date    = element[3]
    { success: true,
      error: nil,
      project: Project.new(id, name, start_date, end_date) }
  end

  def timesheet_good_data(element)
    employee_id = element[0]
    project_id  = element[1]
    date        = element[2]
    minutes     = element[3]
    { success: true,
      error: nil,
      timesheet: Timesheet.new(employee_id, project_id, date, minutes) }
  end

  def bad_data
    { success: false,
      error: 'bad data' }
  end

  def employee_valid?(line)
    line.count == 5 && !line.include?(nil)
  end

  def project_valid?(line)
    line.count == 4 && !line.include?(nil)
  end

  def timesheet_valid?(line)
    line.count == 4 && !line.include?(nil)
  end

  def find_employee_by_id(employee_id)
    @employees.find do |employee|
      employee[:employee] if employee[:employee].id == employee_id
    end
  end

  def find_project_by_id(project_id)
    @projects.find do |project|
      project[:project] if project[:project].id == project_id
    end
  end
end

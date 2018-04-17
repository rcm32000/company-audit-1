class Project
  attr_reader :id,
              :name,
              :start_date,
              :end_date
  def initialize(id, name, start_date, end_date)
    @id         = id.to_i
    @name       = name
    @start_date = start_date
    @end_date   = end_date
  end
end

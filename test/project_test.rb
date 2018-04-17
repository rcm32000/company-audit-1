require './test/test_helper'
require './lib/project'

class ProjectTest < Minitest::Test
  def setup
    @project = Project.new('123', 'Widget Maker', '2015-01-01', '2018-01-01')
  end

  def test_instantiation
    assert_instance_of Project, @project
  end

  def test_attributes
    assert_instance_of Integer, @project.id
    assert_equal 123, @project.id
    assert_equal 'Widget Maker', @project.name
    assert_equal '2015-01-01', @project.start_date
    assert_equal '2018-01-01', @project.end_date
  end
end

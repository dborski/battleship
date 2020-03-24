require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_has_readable_attributes
    assert_equal "B4", @cell.coordinate
  end

  def test_ship_is_nil_by_default
    assert_equal nil, @cell.ship
  end





end

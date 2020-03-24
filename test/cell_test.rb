require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
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

  def test_cell_is_empty_by_default
    assert_equal true, @cell.empty?
  end

  def test_place_ship_adds_to_ship_method
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
  end

  def test_place_ship_makes_cell_not_empty
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.empty?
  end

  def test_fired_upon_is_false_by_default
    assert_equal false, @cell.fired_upon?
  end

  def test_if_firing_on_ship_lowers_health
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
  end




end

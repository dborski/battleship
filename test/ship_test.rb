require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_has_readable_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
  end

  def test_health
    assert_equal 3, @cruiser.health
  end

  def test_not_sunk_by_default
    assert_equal false, @cruiser.sunk?
  end

  def test_hit_lowers_health
    @cruiser.hit
    assert_equal 2, @cruiser.health
    assert_equal 3, @cruiser.length
  end

  def test_hit_lowers_health_twice
    @cruiser.hit
    assert_equal 2, @cruiser.health
    assert_equal 3, @cruiser.length
    @cruiser.hit
    assert_equal 1, @cruiser.health
    assert_equal 3, @cruiser.length
  end

  def test_sunk_when_health_is_0
    @cruiser.hit
    assert_equal 2, @cruiser.health
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    assert_equal 1, @cruiser.health
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    assert_equal 0, @cruiser.health
    assert_equal true, @cruiser.sunk?
  end
end

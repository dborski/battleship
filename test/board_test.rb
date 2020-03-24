require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_cells_returns_a_hash
    assert_instance_of Hash, @board.cells
  end

  def test_16_elements_in_hash
    assert_equal 16, @board.cells.length
  end

  def test_keys_point_to_instances_of_cells
    assert_instance_of Cell, @board.cells.values.first
    assert_instance_of Cell, @board.cells.values.last
  end

  def test_valid_coordinate_true
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
  end

  def test_valid_coordinate_false
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

end

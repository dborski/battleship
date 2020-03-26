require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
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

  def test_valid_placement_number_of_coordinates_same_as_length_of_ship
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_valid_placement_coordinates_are_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@submarine, ["D2", "D3"])
  end

  def test_valid_placement_coordinates_are_not_diagonal
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B2"])
  end

  def test_valid_placement_coordinates_can_be_vertical
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_place_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell1 = @board.cells["A1"]
    cell2 = @board.cells["A2"]
    cell3 = @board.cells["A3"]

    assert_equal @cruiser, cell1.ship
    assert_equal @cruiser, cell2.ship
    assert_equal @cruiser, cell3.ship
    assert_equal true, cell3.ship == cell2.ship
  end

  def test_overlapping_ships
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_render
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.render(true)
  end

  def test_cell_renders_H_when_hit
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell1 = @board.cells["A1"]
    cell1.fire_upon
    @board.render(true)
  end

  def test_cell_renders_M_when_hit_and_missed
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell1 = @board.cells["C4"]
    cell1.fire_upon
    @board.render(true)
  end

  def test_cell_renders_X_when_sunk
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell1 = @board.cells["A1"]
    cell2 = @board.cells["A2"]
    cell3 = @board.cells["A3"]
    cell1.fire_upon
    cell2.fire_upon
    cell3.fire_upon
    @board.render(true)
  end

end
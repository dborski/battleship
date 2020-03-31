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
    assert_instance_of Cell, @board.cells["A1"]
    assert_instance_of Cell, @board.cells["A4"]
    assert_instance_of Cell, @board.cells["D1"]
    assert_instance_of Cell, @board.cells["D4"]
    assert_instance_of Cell, @board.cells["B1"]
    assert_instance_of Cell, @board.cells["B2"]
    assert_instance_of Cell, @board.cells["C4"]
    refute_instance_of Cell, @board.cells["C5"]
    refute_instance_of Cell, @board.cells["M1"]
    refute_instance_of Cell, @board.cells["L1"]
  end

  def test_generate_coordinates
    assert_equal ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"], @board.generate_coordinates
  end

  def test_valid_coordinate_true
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
  end

  def test_create_arrays_of_nums
    assert_equal ["1", "2", "3", "4", "1", "2", "3", "4", "1", "2", "3", "4", "1", "2", "3", "4"], @board.create_array_of_nums(4).flatten
  end


  def test_can_find_consecutive_coordinates_by_length_of_ship
    assert_equal [[1, 2, 3], [2, 3, 4]], @board.consecutive_nums_by_length(@cruiser, ["A1", "A2", "A3"])
    assert_equal [[1, 2], [2, 3], [3, 4]], @board.consecutive_nums_by_length(@submarine, ["A2", "A3"])
  end

  def test_coordinates_same_numbers
    assert_equal false, @board.check_coordinates_same_nums(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.check_coordinates_same_nums(@submarine, ["A2", "A3"])
    assert_equal true, @board.check_coordinates_same_nums(@cruiser, ["B1", "C1", "D1"])
    assert_equal true, @board.check_coordinates_same_nums(@submarine, ["B2", "C2"])
  end

  def test_coordinate_same_letters
    assert_equal true, @board.check_coordinates_same_letters(@cruiser, ["A1", "A2", "A3"])
    assert_equal true, @board.check_coordinates_same_letters(@submarine, ["A2", "A3"])
    assert_equal false, @board.check_coordinates_same_letters(@cruiser, ["A1", "B1", "C1"])
    assert_equal false, @board.check_coordinates_same_letters(@submarine, ["B2", "C2"])
  end

  def test_consecutive_letters_by_length
    assert_equal [[65, 66, 67], [66, 67, 68]], @board.consecutive_letters_by_length(@cruiser, ["A1", "A2", "A3"])
    assert_equal [[65, 66], [66, 67], [67, 68]], @board.consecutive_letters_by_length(@submarine, ["A2", "A3"])
  end

  def test_coordinate_nums
    assert_equal [1, 2, 3], @board.coordinate_nums(@cruiser, ["A1", "A2", "A3"])
    assert_equal [2, 3], @board.coordinate_nums(@submarine, ["A2", "A3"])
  end

  def test_coordinate_letters
    assert_equal [65, 65, 65], @board.coordinate_letters(@cruiser, ["A1", "A2", "A3"])
    assert_equal [65, 65], @board.coordinate_letters(@submarine, ["A2", "A3"])
  end

  def test_nums_same_as_length
    assert_equal true, @board.nums_same_as_length(@cruiser, ["A1", "A2", "A3"])
    assert_equal true, @board.nums_same_as_length(@submarine, ["A2", "A3"])
  end

  def test_letters_same_as_length
    assert_equal true, @board.letters_same_as_length(@cruiser, ["A1", "B1", "C1"])
    assert_equal true, @board.letters_same_as_length(@submarine, ["A2", "B2"])
  end

  def test_ship_on_any_coordinate
    assert_equal false, @board.ship_on_any_coordinate(["A1", "A2", "A3"])
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.place(@submarine, ["C3", "D3"])
    assert_equal true, @board.ship_on_any_coordinate(["A1", "B1", "C1"])
    assert_equal true, @board.ship_on_any_coordinate(["D3", "D4"])
  end

  def test_all_valid_coordinates
    assert_equal true, @board.check_all_valid_coordinates(@cruiser, ["A1", "B1", "C1"])
    assert_equal true, @board.check_all_valid_coordinates(@submarine, ["A2", "B2"])
    assert_equal false, @board.check_all_valid_coordinates(@cruiser, ["A1", "B1", "D5"])
    assert_equal false, @board.check_all_valid_coordinates(@submarine, ["A2", "C5"])
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

  def test_each_coordinate_letter
    assert_equal ["A", "B", "C", "D"], @board.each_coordinate_letter
  end

  def test_first_line
    assert_equal "  1 2 3 4\n", @board.first_line
  end

  def test_render
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.render(false)
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

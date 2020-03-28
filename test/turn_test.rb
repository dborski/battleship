require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/turn'

class TurnTest < Minitest::Test
  def setup
    @user_board = Board.new
    @computer_board = Board.new

    @cruiser_user = Ship.new("Cruiser", 3)
    @submarine_user = Ship.new("Submarine", 2)
    @cruiser_computer = Ship.new("Cruiser", 3)
    @submarine_computer = Ship.new("Submarine", 2)

    @user_board.place(@cruiser_user, ["A1", "A2", "A3"])
    @user_board.place(@submarine_user, ["C1", "C2"])
    @computer_board.place(@cruiser_computer, ["B1", "B2", "B3"])
    @computer_board.place(@submarine_computer, ["D2", "D3"])

    @turn = Turn.new(@user_board, @computer_board)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
  end

  def test_attributes_are_boards
    assert_instance_of Board, @turn.user_board
    assert_instance_of Board, @turn.computer_board
  end

  def test_render_boards
    @turn.render_boards
  end

  def test_user_shoots
    @turn.user_shoots
    @turn.render_boards
  end

  def test_computer_shoots
    16.times {@turn.computer_shoots}
    @turn.render_boards
  end
end

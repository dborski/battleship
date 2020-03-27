require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @user_board = Board.new
    @computer_board = Board.new

    # @cruiser_user = Ship.new("Cruiser", 3)
    # @submarine_user = Ship.new("Submarine", 2)
    # @cruiser_computer = Ship.new("Cruiser", 3)
    # @submarine_computer = Ship.new("Submarine", 2)
    @game = Game.new(@user_board, @computer_board)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_main_menu
    @game.main_menu
  end




end

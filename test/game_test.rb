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
    @cruiser_user = Ship.new("Cruiser", 3)
    @submarine_user = Ship.new("Submarine", 2)
    @cruiser_computer = Ship.new("Cruiser", 3)
    @submarine_computer = Ship.new("Submarine", 2)

    @game = Game.new(@user_board, @computer_board)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_main_menu
    @game.main_menu
  end

  def test_computer_ship_placement
    @game.computer_places_ships(@submarine_computer, @cruiser_computer)
    puts @game.computer_board.render(true)
  end

  def test_user_ship_placement
    @game.user_places_ships(@submarine_user, @cruiser_user)
    puts @game.user_board.render(true)
  end

end

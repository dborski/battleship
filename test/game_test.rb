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
    @user_ships = [@submarine_user, @cruiser_user]
    @computer_ships = [@submarine_computer, @cruiser_computer]

    @game = Game.new(@user_board, @computer_board, @user_ships, @computer_ships)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_main_menu
    skip
    @game.main_menu
  end

  def test_computer_ship_placement
    skip
    @game.computer_places_ships
    puts @game.computer_board.render(true)
  end

  def test_user_ship_placement
    skip
    @game.user_places_ships(@submarine_user, @cruiser_user)
    puts @game.user_board.render(true)
  end

  def test_executes_turn
    skip
    @game.execute_turn
  end

  def test_start_game
    @game.start
  end
end

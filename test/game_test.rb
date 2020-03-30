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

    @game = Game.new(@user_board, @computer_board)
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

  def test_list_of_ships
    assert_equal "The Submarine is 2 units long and the Cruiser is 3 units long." , @game.list_of_ships
  end

  def test_user_ship_placement
    skip
    @game.user_places_ships
    puts @game.user_board.render(true)
  end

  def test_executes_turn
    skip
    @game.execute_turn
  end

  def test_start_game
    skip
    @game.start
  end
end

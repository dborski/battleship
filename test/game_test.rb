require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_main_menu
    skip
    @game.main_menu
  end

  def test_it_creates_ships
    @game.create_ships

    assert_equal [Ship.new("Submarine", 2), Ship.new("Cruiser", 3)], @game.user_ships
    assert_equal [Ship.new("Submarine", 2), Ship.new("Cruiser", 3)], @game.computer_ships
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
    @game.start
  end

end

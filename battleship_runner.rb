require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/turn'
require './lib/game'

user_board = Board.new
computer_board = Board.new

game = Game.new(user_board, computer_board)
game.start

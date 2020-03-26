class Turn

  attr_reader :user_board, :computer_board
  def initialize(user_board, computer_board)
    @user_board = user_board
    @computer_board = computer_board
  end

  def render_boards
    puts "=============COMPUTER BOARD=============\n#{computer_board.render}\n==============PLAYER BOARD==============\n#{user_board.render(true)}"
  end

  def user_shoots
    input = get_user_input
    @computer_board.cells[input].fire_upon
  end

  def get_user_input
    print "Enter the coordinate for your shot:\n>"
    input = gets.chomp.upcase
    until user_board.valid_coordinate?(input)
      print "Please enter a valid coordinate:\n>"
      input = gets.chomp.upcase
    end
    input
  end

end

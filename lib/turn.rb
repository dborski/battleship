class Turn

  attr_reader :user_board, :computer_board
  def initialize(user_board, computer_board)
    @user_board = user_board
    @computer_board = computer_board
  end

  def render_boards
    puts("=============COMPUTER BOARD=============\n#{computer_board.render}" +
    "\n==============PLAYER BOARD==============\n#{user_board.render(true)}")
  end

  def user_shoots
    input = get_user_input
    until @computer_board.cells[input].render == "."
      input = coordinate_already_fired_upon
    end
    render_value_hash = {"M" => "was a miss", "H"=> "was a hit", "X"=>"sunk the ship"}
    @computer_board.cells[input].fire_upon
    puts "Your shot on #{input} #{render_value_hash[@computer_board.cells[input].render]}."
  end

  def computer_shoots
    input = @user_board.cells.keys.shuffle[0]
    until @user_board.cells[input].render == "."
      input = @user_board.cells.keys.shuffle[0]
    end
    render_value_hash = {"M" => "was a miss", "H"=> "was a hit", "X"=>"sunk the ship"}
    @user_board.cells[input].fire_upon
    puts "My shot on #{input} #{render_value_hash[@user_board.cells[input].render]}."
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

  def coordinate_already_fired_upon
    print "That coordinate was already fired upon. Choose another coordinate:\n>"
    input = gets.chomp.upcase
    until user_board.valid_coordinate?(input)
      print "Please enter a valid coordinate:\n>"
      input = gets.chomp.upcase
    end
    input
  end

end

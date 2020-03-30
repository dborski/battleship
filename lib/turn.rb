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
    render_value_hash = {"M" => "was a miss", "H"=> "was a hit", "X"=>"sunk my"}
    @computer_board.cells[input].fire_upon
    print "Your shot on #{input} "
    puts "#{render_value_hash[@computer_board.cells[input].render]}." if @computer_board.cells[input].render == "M" || @computer_board.cells[input].render == "H"
    puts "#{render_value_hash[@computer_board.cells[input].render]} #{@computer_board.cells[input].ship.name}" if @computer_board.cells[input].render == "X"
  end

  def computer_shoots
    input = @user_board.cells.keys.shuffle[0]
    until @user_board.cells[input].render == "."
      input = @user_board.cells.keys.shuffle[0]
    end
    render_value_hash = {"M" => "was a miss", "H"=> "was a hit", "X"=>"sunk your"}
    @user_board.cells[input].fire_upon
    print "My shot on #{input} "
    puts "#{render_value_hash[@user_board.cells[input].render]}." if @user_board.cells[input].render == "M" || @user_board.cells[input].render == "H"
    puts "#{render_value_hash[@user_board.cells[input].render]} #{@user_board.cells[input].ship.name}" if @user_board.cells[input].render == "X"
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

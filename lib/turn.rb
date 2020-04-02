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
    input = user_input
    @computer_board.cells[input].fire_upon
    print_user_shot_result(input)
  end

  def user_input
    input = get_user_input
    until input_cell_render_value(@computer_board, input) == "."
      input = coordinate_already_fired_upon
    end
    input
  end

  def print_user_shot_result(input)
    render_value_hash = {"M" => "was a miss", "H"=> "was a hit", "X"=>"sunk my"}
    print "Your shot on #{input} "
    if input_cell_render_value(@computer_board, input) == "M" || input_cell_render_value(@computer_board, input) == "H"
      puts "#{render_value_hash[input_cell_render_value(@computer_board, input)]}."
    elsif input_cell_render_value(@computer_board, input) == "X"
      puts "#{render_value_hash[input_cell_render_value(@computer_board, input)]} #{@computer_board.cells[input].ship.name}"
    end
    puts
  end

  def computer_shoots
    input = computer_input
    @user_board.cells[input].fire_upon
    puts "Thinking"
    puts "."
    sleep(1)
    puts ".."
    sleep(1)
    puts "..."
    sleep(1)
    print_computer_shot_result(input)
  end

  def computer_input
    input = @user_board.cells.keys.shuffle[0]
    until input_cell_render_value(@user_board, input) == "."
      input = @user_board.cells.keys.shuffle[0]
    end
    input
  end

  def print_computer_shot_result(input)
    render_value_hash = {"M" => "was a miss", "H"=> "was a hit", "X"=>"sunk your"}
    print "My shot on #{input} "
    if input_cell_render_value(@user_board, input) == "M" || input_cell_render_value(@user_board, input) == "H"
      puts "#{render_value_hash[input_cell_render_value(@user_board, input)]}."
    elsif input_cell_render_value(@user_board, input) == "X"
      puts "#{render_value_hash[input_cell_render_value(@user_board, input)]} #{@user_board.cells[input].ship.name}"
    end
    puts
  end

  def input_cell_render_value(board, input)
    board.cells[input].render
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

class Game

  attr_reader :user_board, :computer_board
  def initialize
    @user_board = nil
    @computer_board = nil
    @user_ships = [Ship.new("Submarine", 2), Ship.new("Cruiser", 3)]
    @computer_ships = [Ship.new("Submarine", 2), Ship.new("Cruiser", 3)]
  end

  def start
    while true
      main_menu
      variable_boards
      create_ships
      computer_places_ships
      tell_user_to_place_ships
      user_places_ships
      until user_lost || computer_lost
        execute_turn
      end
      final_result
      reset_ships
    end
  end

  def main_menu
    input = welcome_message
    until input == "p" || input == "q"
      input = welcome_message
    end
    if input == "p"
      return
    elsif input == "q"
      exit
    end
  end

  def welcome_message
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    gets.chomp.downcase
  end

  def variable_boards
    size = ask_for_a_number
    until size > 3 && size < 11
      size = ask_for_a_number
    end
    @user_board = Board.new(size)
    @computer_board = Board.new(size)
  end


  def ask_for_a_number
    puts "What size board would you like to play on?"
    puts "Enter a number between 4 and 10 to determine the width/height of your grid."
    gets.chomp.to_i
  end

  def create_ships
    user_input = ask_user_to_create_ships
    until user_input == "y" || user_input == "n"
      user_input = ask_user_to_create_ships
    end
    return if user_input == "n"
    @user_ships.clear
    @computer_ships.clear
    number_of_ships = ask_user_for_how_many_ships
    number_of_ships.times do |num|
      if num == 0
        ship_name = get_name
      else
        ship_name = other_names
      end
      ship_length = get_length
      @user_ships << Ship.new(ship_name, ship_length)
      @computer_ships << Ship.new(ship_name, ship_length)
    end
  end

  def ask_user_to_create_ships
    puts "Would you like to create your own custom ships or use the default ones?"
    puts "The default ships are Cruiser (length 3) and Submarine (length 2) Y or N?"
    gets.chomp.downcase
  end

  def get_name
    puts "What would you like to call your first ship?"
    gets.chomp
  end

  def other_names
    puts "What would you like to call your next ship?"
    gets.chomp
  end

  def get_length
    puts "How long is your ship? It must be shorter than the width of your board"
    input = gets.chomp.to_i
    until input < @user_board.size && input > 0
      puts "That length is invalid"
      input = gets.chomp.to_i
    end
    input
  end

  def ask_user_for_how_many_ships
    puts "How many ships would you like to create? You are allowed to make #{(@user_board.size / 2 + 1).to_i} ships."
    input = gets.chomp.to_i
    until input <= (@user_board.size / 2 + 1).to_i
      input = gets.chomp.to_i
    end
    input
  end

  def computer_places_ships
    @computer_ships.each do |ship|
      random_ship_placement(ship)
    end
    puts "Thinking"
    puts "."
    sleep(1)
    puts ".."
    sleep(1)
    puts "..."
    sleep(1)
  end

  def tell_user_to_place_ships
    print "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\n"
    puts list_of_ships
    puts @user_board.render
  end

  def list_of_ships
    @user_ships.reduce("") do |ships_list, ship|
      if ship == @user_ships.first
        ships_list += "The #{ship.name.capitalize} is #{ship.length} units long"
      elsif ship == @user_ships.last
        ships_list += " and the #{ship.name.capitalize} is #{ship.length} units long."
      else
        ships_list +=  ", the #{ship.name.capitalize} is #{ship.length} units long"
      end
    end
  end

  def random_ship_placement(ship)
    coordinates = []
    ship.length.times {coordinates <<  computer_chooses_random_cell }
    until @computer_board.valid_placement?(ship, coordinates)
      coordinates.shift
      coordinates << computer_chooses_random_cell
    end
    @computer_board.place(ship, coordinates)
  end

  def computer_chooses_random_cell
    @computer_board.cells.keys.shuffle[0]
  end

  def user_places_ships
    @user_ships.each do |ship|
      user_places_one_ship(ship)
    end
  end

  def user_places_one_ship(ship)
    coordinates = get_coordinates_from_user(ship)
    until @user_board.valid_placement?(ship, coordinates)
      coordinates = user_gave_invalid_coordinates
    end
    @user_board.place(ship, coordinates)
    unless ship == @user_ships.last
      puts @user_board.render(true)
    end
  end

  def get_coordinates_from_user(ship)
    print "Enter the squares for the #{ship.name.capitalize} (#{ship.length} spaces):\n>"
    gets.chomp.upcase.split(" ")
  end

  def user_gave_invalid_coordinates
    print "Those are invalid coordinates. Please try again:\n>"
    gets.chomp.upcase.split(" ")
  end

  def execute_turn
    turn = Turn.new(@user_board, @computer_board)
    turn.render_boards
    turn.user_shoots
    return if computer_lost
    turn.computer_shoots
  end

  def user_lost
    @user_ships.all? do |ship|
      ship.sunk?
    end
  end

  def computer_lost
    @computer_ships.all? do |ship|
      ship.sunk?
    end
  end

  def final_result
    if user_lost
      puts "I won!"
    elsif computer_lost
      puts "You won!"
    end
  end

  def reset_ships
    @user_ships = [Ship.new("Submarine", 2), Ship.new("Cruiser", 3)]
    @computer_ships = [Ship.new("Submarine", 2), Ship.new("Cruiser", 3)]
  end

end

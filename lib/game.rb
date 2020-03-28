class Game

  attr_reader :user_board, :computer_board, :user_ships, :computer_ships
  def initialize(user_board, computer_board, user_ships, computer_ships)
    @user_board = user_board
    @computer_board = computer_board
    @user_ships = user_ships
    @computer_ships = computer_ships
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    until input == "p" || input == "q"
      puts "Welcome to BATTLESHIP"
      puts "Enter p to play. Enter q to quit."
      input = gets.chomp.downcase
    end

    if input == "p"
      return
    elsif input == "q"
      exit
    end
  end

  def computer_places_ships(submarine = @computer_ships[0], cruiser = @computer_ships[1])
    computer_places_submarine(submarine)
    computer_places_cruiser(cruiser)
    puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."
    puts @user_board.render
  end

  def computer_places_submarine(submarine)
    coordinates = []
    submarine.length.times {coordinates <<  @computer_board.cells.keys.shuffle[0] }
    until @computer_board.valid_placement?(submarine, coordinates)
      coordinates.shift
      coordinates << @computer_board.cells.keys.shuffle[0]
    end
    @computer_board.place(submarine, coordinates)
  end

  def computer_places_cruiser(cruiser)
    coordinates = []
    cruiser.length.times { coordinates << @computer_board.cells.keys.shuffle[0]}
    until @computer_board.valid_placement?(cruiser, coordinates)
      coordinates.shift
      coordinates << @computer_board.cells.keys.shuffle[0]
    end
    @computer_board.place(cruiser, coordinates)
  end

  def user_places_ships(submarine, cruiser)
    user_places_submarine(submarine)
    user_places_cruiser(cruiser)
  end

  def user_places_submarine(submarine)
    print "Enter the squares for the Submarine (2 spaces):\n>"
    input = gets.chomp.upcase
    coordinates = input.split(" ")
    until @user_board.valid_placement?(submarine, coordinates)
      print "Those are invalid coordinates. Please try again:\n>"
      input = gets.chomp.upcase
      coordinates = input.split(" ")
    end
    @user_board.place(submarine, coordinates)
    puts @user_board.render(true)
  end

  def user_places_cruiser(cruiser)
    print "Enter the squares for the Cruiser (3 spaces):\n>"
    input = gets.chomp.upcase
    coordinates = input.split(" ")
    until @user_board.valid_placement?(cruiser, coordinates)
      print "Those are invalid coordinates. Please try again:\n>"
      input = gets.chomp.upcase
      coordinates = input.split(" ")
    end
    @user_board.place(cruiser, coordinates)
  end

end

class Game

  attr_reader :user_board, :computer_board
  def initialize(user_board, computer_board)
    @user_board = user_board
    @computer_board = computer_board
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

  def computer_places_ships(submarine, cruiser)
    computer_places_submarine(submarine)
    computer_places_cruiser(cruiser)
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

end

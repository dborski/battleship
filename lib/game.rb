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
end

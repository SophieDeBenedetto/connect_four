require 'pry'

class ConnectFour

  BOARD_MAP = {
      "A1" => 0,
      "A2" => 1, 
      "A3" => 2,
      "A4" => 3, 
      "B1" => 4,
      "B2" => 5,
      "B3" => 6,
      "B4" => 7, 
      "C1" => 8, 
      "C2" => 9, 
      "C3" => 10, 
      "C4" => 11, 
      "D1" => 12, 
      "D2" => 13, 
      "D3" => 14, 
      "D4" => 15
    }

  WIN_COMBOS = [
    [0, 1, 2, 3], 
    [4, 5, 6, 7], 
    [8, 9, 10, 11], 
    [12, 13, 14, 15], 
    [0, 5, 10, 15],
    [12, 9, 6, 3]
  ]

  attr_accessor :board, :player_color, :computer_color, :comp_row, :comp_col, :turn_count, :winner

  def initialize
    @board = Array.new(16, " ")
    @turn_count = 0
  end

  def choose_color
    puts "Please enter your color choice: red or black"
    input = gets.chomp
    if input.downcase == "red"
      self.player_color = "R" 
      self.computer_color = "B"
    else
      self.player_color = "B"
      self.computer_color = "R"
    end
  end

  def won?
    WIN_COMBOS.detect do |combo|
      board[combo[0]] == board[combo[1]] && 
      board[combo[0]] == board[combo[2]] && 
      board[combo[0]] == board[combo[3]] &&
      spot_taken?(combo[0])
    end
  end


  def display_board
    puts "        1       2       3      4       "
    puts "---|-------|--------|--------|------|"
    puts "A: | #{board[0]}     |     #{board[1]}  |   #{board[2]}    | #{board[3]}    |"
    puts "B: | #{board[4]}     |     #{board[5]}  |     #{board[6]}  |   #{board[7]}  |"
    puts "C: | #{board[8]}     |     #{board[9]}  |      #{board[10]} |    #{board[11]} |"
    puts "D: | #{board[12]}     |       #{board[13]}|   #{board[14]}    |    #{board[15]} |"
  end

  def prompt_user
    puts "please enter a location"
  end

  def spot_taken?(spot)
    board[spot] != " "
  end


  def input_map(location)
    BOARD_MAP[location]
  end

  def player_turn
    prompt_user
    choice = gets.chomp
    location = input_map(choice)
    if spot_taken?(location)
      puts "Sorry, that spot is taken, please try again!"
      player_turn
    else
      board[location] = self.player_color
    end
    @turn_count += 1
  end

  def computer_turn
    location = generate_computer_location
    if !spot_taken?(location)
      board[location] = self.computer_color
    else
     computer_turn
    end
    @turn_count += 1
  end

  def generate_computer_location
    (0..15).to_a.sample
  end


  def full?
    board.all? { |spot| spot == "R" || spot == "B" }
  end

  def tie?
    full? && !won?
  end

  def winner
    winner = nil
    if won?
      winner = board[won?[0]]
    end
    winner

  end

  def game_over
    won? || tie?
  end

  def play
    choose_color
    display_board
    while !game_over
      player_turn
      display_board
      game_over
      computer_turn
      display_board
      game_over
    end
    if won?
      puts "the winner is #{winner}"
    else
      puts "TIE!"
    end
  end
end
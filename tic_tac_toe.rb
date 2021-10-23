# frozen_string_literal: true

# Class to handle board related functions
class TicTacToe
  attr_reader :max, :coords
  BLANK_VALUE = Float::INFINITY

  def initialize(size = 3)
    @size = size.odd? ? size : size + 1
    @board = Array.new(size) { Array.new(size, BLANK_VALUE) }
    @coords = {}

    @max = 1
    @size.times do |x|
      @size.times do |y|
        @coords[@max] = [x, y]
        @max += 1
      end
    end

    @max -= 1 # Adjust max so we have the right number of elements.
  end

  def show_board
    chars = ['X', 'O', '-']
    @board.each do |row|
      row.each do |value|
        to_display = value.infinite? ? 2 : value
        print "#{chars[to_display]} "
      end
      puts "\n"
    end
    puts "\n"
  end

  def coordinates(input)
    @coords[input]
  end

  def board_full?
    @board.none? { |row| row.include?(BLANK_VALUE) }
  end

  def loc_valid?(location)
    (1..@max).include?(location)
  end

  def loc_empty?(location)
    x, y = coordinates(location)
    @board[x][y].infinite? ? true : false
  end

  def add_move(location, input = BLANK_VALUE)
    # Assume params are valid (loc is in bounds, space is empty, and input is correct). Check for errors in Game class
    x, y = coordinates(location)
    @board[x][y] = input
  end

  def any_winner?
    return true if check_row_win || check_col_win || check_diag_win

    false
  end

  def test_fill
    fill_board
  end

  def test_display
    @board.each { |row| p row }
  end

  private

  def fill_board
    (@size**2).times { |i| add_move(i + 1, Random.rand(2)) }
  end

  def check_row_win
    @board.each do |row|
      checksum = row.reduce(:+)
      return true if checksum.zero? || checksum == @size
    end
    false
  end

  def check_col_win
    @size.times do |i|
      checksum = 0
      @board.each do |row|
        checksum += row[i]
      end
      return true if checksum.zero? || checksum == @size
    end
    false
  end

  def check_diag_win
    board_to_check = @board
    board_to_check = @board.each.map(&:reverse) if @board[0][@size - 1] == @board[@size - 1][0]
    checksum = 0
    @size.times do |i|
      checksum += board_to_check[i][i]
    end
    checksum.zero? || checksum == @size ? true : false
  end
end

# Class to handle input and validation of input
class Player
  def initialize()
  end

  def answer_prompt
    gets.chomp
  end

end

# Class to handle playing the game
class PlayGame
  def initialize
    @board = TicTacToe.new(3)
    @positions = @board.max

    @players = Player.new()

    @turn = 0
  end

  def play_round
    #Get input for player 1, validate it and play it once validated and increment turn
    #Get input for player 2, validate it and play it once validated and increment turn
    #If there are more than 5 turns, check if the new entries resulted in a win or if the board is full.
    # If not exit, play round again

    until @board.board_full? || @board.any_winner? do
      puts "Full? #{@board.board_full?}, Winner? #{@board.any_winner?}, Turn: #{@turn}"
      @board.show_board
      valid = false
      until valid do
        print "Player (#{(@turn % 2)+1}, please select a position to play (1 - #{@positions}): "
        answer = @players.answer_prompt.to_i
        valid = true if @board.loc_valid?(answer) && @board.loc_empty?(answer)
      end

      @board.add_move(answer, @turn % 2)
      increment_turn
    end
  end

  def play_again?
    #Get input for player 1, validate it
    #Get input for player 2, validate it
    #If both inputs are y, play again else exit
    exit
  end

  def validate_position
    #Check if the entered position is valid - is it in bounds? Is it empty?

  end

  def validate_yn
    #Check if the answer is valid - yes or no?
  end

  def increment_turn
    @turn += 1
  end
end

board_test = TicTacToe.new(3)
p board_test.max
p board_test.coords
board_test.test_display
(1...9).each { |i| p board_test.loc_valid?(i) }
p board_test.loc_valid?(15)


tic = PlayGame.new()
tic.play_round

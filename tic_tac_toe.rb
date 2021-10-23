# frozen_string_literal: true

# Class to handle board related functions
class TicTacToe
  attr_reader :max
  BLANK_VALUE = Float::INFINITY

  def initialize(size = 3)
    @size = size.odd? ? size : size + 1
    @board = Array.new(@size) { Array.new(@size, BLANK_VALUE) }
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

  def show_board(map=false)
    chars = ['X', 'O', '-']
    loc = 1
    @board.each do |row|
      row.each do |value|
        to_display = value.infinite? ? 2 : value
        if map then
          print "%02d " % loc
          loc += 1
        else 
          print "#{chars[to_display]} "
        end
      end
      puts "\n"
    end
    puts "\n"
  end

  def coordinates(input)
    @coords[input]
  end

  def full?
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
    x, y = coordinates(location)
    @board[x][y] = input
  end

  def winner?
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

# Class to handle playing the game
class PlayGame
  def initialize
    @board = TicTacToe.new(3)
    @positions = @board.max

    @turn = 0
  end

  def play_round
    @board.show_board(true)
    until @board.winner? || @board.full? do
      @board.show_board if @turn > 0
      valid = false
      until valid do
        print "Player #{(@turn % 2)+1}, please select a position to play (1 - #{@positions}): "
        answer = gets.chomp.to_i
        valid = true if @board.loc_valid?(answer) && @board.loc_empty?(answer)
      end

      @board.add_move(answer, @turn % 2)
      increment_turn
    end

    @board.show_board
    win_msg = @turn.odd? ? "Player 1 won!" : "Player 2 won!"
    puts @board.winner? ? win_msg : "Tie game!"
    play_again?
  end

  def play_again?
    valid = false
    until valid do
      print "Did you want to play again? (y/n) "
      answer = gets.chomp.downcase
      valid = true if ['y', 'n'].include?(answer)
    end

    if answer == "y" then
      valid = false
      until valid do
        new_max = 25
        print "How many s? (9-#{new_max}) "
        answer = Math.sqrt(gets.chomp.to_i)
        valid = true if answer.between?(9,new_max)
      end
      @board = TicTacToe.new(answer.to_i)
      @positions = @board.max
      @turn = 0
      play_round
    else
      exit
    end
  end

  def increment_turn
    @turn += 1
  end
end

tic = PlayGame.new()
tic.play_round

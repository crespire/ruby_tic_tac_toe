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

  def show_board()
    chars = %w[X O]
    loc = 1
    print '----' * @size + '-' * (@size - 1) + "\n"
    @board.each do |row|
      row.each do |value|
        to_display = value.infinite? ? 2 : value
        print to_display == 2 ? loc.to_s.center(4) : chars[to_display].to_s.center(4)
        print '|' if (loc % @size).positive?
        loc += 1
      end
      print "\n" + '----' * @size + '-' * (@size - 1) + "\n"
    end
    puts "\n"
  end

  def full?
    @board.none? { |row| row.include?(BLANK_VALUE) }
  end

  def loc_valid?(location)
    (1..@max).include?(location)
  end

  def loc_empty?(location)
    return nil unless loc_valid?(location)

    x, y = coordinates(location)
    @board[x][y].infinite?
  end

  def add_move(location, input = BLANK_VALUE)
    x, y = coordinates(location)
    @board[x][y] = input
  end

  def winner?
    return true if check_row_win || check_col_win || check_diag_win

    false
  end

  private

  def coordinates(input)
    @coords[input]
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
    board_reg = @board.dup
    board_rev = @board.each.map(&:reverse)
    checksum_for = 0
    checksum_rev = 0
    @size.times do |i|
      checksum_for += board_reg[i][i]
      checksum_rev += board_rev[i][i]
    end

    if checksum_for.finite?
      return true if checksum_for.zero? || checksum_for == @size
    elsif checksum_rev.finite?
      return true if checksum_rev.zero? || checksum_rev == @size
    end

    false
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
    until @board.winner? || @board.full?
      @board.show_board
      valid = false
      until valid
        print "Player #{(@turn % 2) + 1}, please select a position to play (1 - #{@positions}): "
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
        print "How many positions? (9-#{new_max}) "
        answer = gets.chomp.to_i
        valid = true if answer.between?(9, new_max)
      end
      @board = TicTacToe.new(Math.sqrt(answer).to_i)
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

#tic = PlayGame.new()
#tic.play_round

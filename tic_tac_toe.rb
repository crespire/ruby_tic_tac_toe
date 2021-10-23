# frozen_string_literal: true

# Class to handle board related functions
class TicTacToe
  BLANK_VALUE = Float::INFINITY

  def initialize(size = 3)
    @size = size.odd? ? size : size + 1
    @board = Array.new(size) { Array.new(size, BLANK_VALUE) }
    @coords = {}
    loc = 1
    
    @size.times do |x|
      @size.times do |y|
        @coords[loc] = [x, y]
        loc += 1
      end
    end
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
    # Given an input of 1 through 9, translate that to the index numbers needed to access that space.
    # 1 | 2 | 3
    # 4 | 5 | 6
    # 7 | 8 | 9

    #map = { 1 => [0, 0], 2 => [0, 1], 3 => [0, 2],
     #       4 => [1, 0], 5 => [1, 1], 6 => [1, 2],
      #      7 => [2, 0], 8 => [2, 1], 9 => [2, 2] }

    #map[input]
    @coords[input]
  end

  def board_full?
    @board.none? { |row| row.include?(BLANK_VALUE) }
  end

  def loc_empty?(location)
    x, y = coordinates(location)
    @board[x][y].infinite? ? true : false
  end

  def add_move(location, input = BLANK_VALUE)
    # Assume coordinates checked so space is empty
    # Assume input is correct, but default to game blank. Check for errors in the Game class
    x, y = coordinates(location)
    @board[x][y] = input
  end

  def any_winner?
    return false if @turn < 5
    return true if check_row_win || check_col_win || check_diag_win

    false
  end

  def test_fill
    fill_board
  end

  def test_display
    @board.each do |row|
      p row
    end
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
    col_ind = (0...@size)
    # For each column, add the row value at the column index to checksum
    # If checksum is 0 or board size, then return a win.
    col_ind.each do |i|
      checksum = 0
      @board.each do |row|
        checksum += row[i]
      end
      return true if checksum.zero? || checksum == @size
    end
    false
  end

  def check_diag_win
    # Check [0,0] and [size,size] == then check normal board
    # else [0, size] and [size, 0] == check reverse board
    board_to_check = @board
    board_to_check = @board.each.map(&:reverse) if @board[0][@size - 1] == @board[@size - 1][0]
    checksum = 0
    @size.times do |i|
      checksum += board_to_check[i][i]
    end
    checksum.zero? || checksum == @size ? true : false
  end
end

game = TicTacToe.new
game.show_board
game.test_fill
game.show_board
p game.board_full?
p game.loc_empty?(5)
game.add_move(5, TicTacToe::BLANK_VALUE)
game.show_board
p game.board_full?
p game.loc_empty?(5)
game.test_display

game2 = TicTacToe.new
game2.add_move(1, 0)
game2.add_move(2, 1)
game2.add_move(5, 0)
game2.add_move(6, 1)
game2.add_move(7, 0)
p game2.test_display
game2.show_board
p game2.any_winner?
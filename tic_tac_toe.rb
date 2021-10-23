# frozen_string_literal: true

# Class to handle board related functions
class TicTacToe
  BLANK_VALUE = Float::INFINITY

  def initialize(size = 3)
    @size = size.odd? ? size : size + 1
    @board = Array.new(size) { Array.new(size, BLANK_VALUE) }
    @coords = {}

    @loc = 1
    @size.times do |x|
      @size.times do |y|
        @coords[@loc] = [x, y]
        @loc += 1
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
    @coords[input]
  end

  def board_full?
    @board.none? { |row| row.include?(BLANK_VALUE) }
  end

  def loc_valid?(location)
    (1..@loc).include?(location)
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
  def initialize(token, data)
    @token = token
    @data = data
  end

  def answer_prompt
    gets.chomp
  end

end

# Class to handle playing the game
class PlayGame
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

game3 = TicTacToe.new(5)
game3.add_move(1, 0)
game3.add_move(2, 0)
game3.add_move(3, 0)
game3.add_move(4, 1)
game3.add_move(5, 0)
game3.add_move(15, 1)
game3.add_move(9, 1)
game3.add_move(14, 1)
game3.add_move(19, 1)
game3.add_move(24, 1)
p game3.test_display
game3.show_board
p game3.any_winner?

p1 = Player.new("X", 0)
p p1.answer_prompt
class TicTacToe
  attr_reader :turn

  def initialize(size=3)
    @turn = 0
    @size = size
    @board = Array.new(size) {Array.new(size, nil)}
  end

  def show_board
    chars = ['X', 'O', ' ']
    @board.each do |row|
      row.each do |value|
        to_display = value.nil? ? 2 : value
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

    map = { 1 => [0, 0], 2 => [0, 1], 3 => [0, 2],
            4 => [1, 0], 5 => [1, 1], 6 => [1, 2],
            7 => [2, 0], 8 => [2, 1], 9 => [2, 2] }

    map[input]
  end

  def board_full?
    @board.none? { |row| row.include?(nil) }
  end

  def loc_empty?(location)
    x, y = coordinates(location)
    @board[x][y].nil?
  end

  def add_move(location, input="b")
    # Assume coordinates checked so space is empty
    # Add turn % 2 to the specified position otherwise, add specified input
    x, y = coordinates(location)
    to_add = input == "b" ? @turn % 2 : input
    @board[x][y] = to_add
    self.increment_turn()
  end

  def test_fill
    self.fill_board
  end

  def any_winner?
    # If turns less than 5, return nil - not enough moves for a winner.
    # Check rows
    # Check columns
    # Check diagonals
    # if true, return the winner!
  end

  private
  def fill_board
    (@size ** 2).times { |i| self.add_move(i+1) }
  end

  def increment_turn
    @turn += 1
  end
end

game = TicTacToe.new()
game.show_board
game.test_fill
game.show_board
p game.board_full?
p game.loc_empty?(5)
game.add_move(5, nil)
game.show_board
p game.board_full?
p game.loc_empty?(5)
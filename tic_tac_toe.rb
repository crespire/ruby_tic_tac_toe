class TicTacToe
  attr_reader :turn

  def initialize(size=3)
    @turn = 0
    @size = size
    @board = Array.new(size) {Array.new(size, nil)}
  end

  def show_board
    @board.each do |row|
      row.each do |value|
        to_display = value.nil? ? "  " : value.to_s + " "
        print to_display
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

  def is_loc_empty?(location)
    x, y = coordinates(location)
    @board[x][y].empty?
  end

  def test_fill
    self.fill_board
  end

  private
  def fill_board
    (@size ** 2).times { |i| self.add_move(i+1) }
  end
end

game = TicTacToe.new()
game.show_board
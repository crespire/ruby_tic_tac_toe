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
                print value.to_s + " "
            end
            puts "\n"
        end
    end

end

game = TicTacToe.new()
game.show_board
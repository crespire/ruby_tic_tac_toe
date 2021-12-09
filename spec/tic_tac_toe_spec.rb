# frozen_string_literal: true

require_relative '../main'

describe TicTacToe do
  describe '#initialize' do
    context 'when no parameters are passed to init' do
      subject(:game) { described_class.new }

      it 'makes a board of the right size' do
        blank = Float::INFINITY
        board = game.instance_variable_get(:@board)
        expect(board).to eq([[blank, blank, blank], [blank, blank, blank], [blank, blank, blank]])
      end

      it 'generates the correct coordinates for second to last cell' do
        coords = game.instance_variable_get(:@coords)
        expect(coords[8]).to eq([2, 1])
      end

      it 'has the correct value for max' do
        expect(game.max).to eq(9)
      end
    end

    context 'when board size is specified' do
      subject(:game5) { described_class.new(5) }

      it 'makes a board of the right size' do
        blank = Float::INFINITY
        board = game5.instance_variable_get(:@board)
        expect(board).to eq([[blank, blank, blank, blank, blank], [blank, blank, blank, blank, blank], [blank, blank, blank, blank, blank], [blank, blank, blank, blank, blank], [blank, blank, blank, blank, blank]])
      end

      it 'generates the correct coordinates for second to last cell' do
        coords = game5.instance_variable_get(:@coords)
        expect(coords[24]).to eq([4, 3])
      end

      it 'has the correct value for max' do
        expect(game5.max).to eq(25)
      end
    end
  end

  describe '#show_board' do
    # Primarily puts the board, no need to test
  end

  describe '#add_move' do
    subject(:add_game) { described_class.new }
    let(:board_add) { add_game.instance_variable_get(:@board) }

    context 'for the standard board' do
      it 'adds a move to the board' do
        add_game.add_move(5, 1)
        expect(board_add.dig(1, 1)).to eq(1)
      end

      it 'adds a blank value if no input is specified' do
        add_game.add_move(5, 1)
        add_game.add_move(5)
        expect(board_add.dig(1, 1)).to eq(Float::INFINITY)
      end
    end
  end

  describe '#full?' do
    context 'for the default board' do
      subject(:full_game) { described_class.new }
      let(:board_full) { full_game.instance_variable_get(:@board) }

      it 'returns true when the board is full' do
        board_full.each { |row| row.fill(1) }
        expect(full_game).to be_full
      end

      it 'returns false when the board has a spot open' do
        board_full.each { |row| row.fill(1) }
        full_game.add_move(5)
        expect(full_game).to_not be_full
      end
    end

    context 'for a custom board' do
      subject(:full_game_5) { described_class.new(5) }
      let(:board_full_5) { full_game_5.instance_variable_get(:@board) }

      it 'returns true when the board is full' do
        board_full_5.each { |row| row.fill(1) }
        expect(full_game_5).to be_full
      end

      it 'returns false when the board has a free spot' do
        board_full_5.each { |row| row.fill(1) }
        full_game_5.add_move(24)
        expect(full_game_5).to_not be_full
      end
    end
  end

  describe '#loc_valid?' do
    context 'for the default board' do
      subject(:loc_std) { described_class.new }

      it 'returns true when provided a location in bounds' do
        expect(loc_std.loc_valid?(5)).to be true
      end

      it 'returns false when provided an out of bounds location' do
        expect(loc_std.loc_valid?(10)).to be false
      end
    end

    context 'for a larger, custom board' do
      subject(:loc_lrg) { described_class.new(7) }
      it 'returns true when provided an inbound location' do
        expect(loc_lrg.loc_valid?(40)).to be true
      end

      it 'returns false when provided an out of bounds location' do
        expect(loc_lrg.loc_valid?(-5)).to be false
      end
    end
  end

  describe '#loc_empty?' do
    context 'for the standard board' do
      subject(:empty_std) { described_class.new }

      it 'returns true if the location is empty' do
        expect(empty_std.loc_empty?(5)).to be_truthy
      end

      it 'returns false if the location is full' do
        empty_std.add_move(5, 1)
        expect(empty_std.loc_empty?(5)).to be_falsey
      end

      it 'returns nil if the location is out of bounds' do
        expect(empty_std.loc_empty?(10)).to be nil
      end
    end
  end

  describe '#winner?' do
    context 'for the standard board' do
      subject(:win_game) { described_class.new }

      it 'returns true for a row win' do
        win_game.add_move(1, 1)
        win_game.add_move(2, 1)
        win_game.add_move(3, 1)
        expect(win_game).to be_winner
      end

      it 'returns true for a column win' do
        win_game.add_move(3, 1)
        win_game.add_move(6, 1)
        win_game.add_move(9, 1)
        expect(win_game).to be_winner
      end

      it 'returns true for a / diagonal win' do
        win_game.add_move(3, 1)
        win_game.add_move(5, 1)
        win_game.add_move(7, 1)
        expect(win_game).to be_winner
      end

      it 'returns true for a \ diagonal win' do
        win_game.add_move(1, 1)
        win_game.add_move(5, 1)
        win_game.add_move(9, 1)
        expect(win_game).to be_winner
      end
    end

    context 'for custom 5 length board' do
      subject(:win5_game) { described_class.new(5) }

      it 'returns true for a row win' do
        win5_game.add_move(1, 1)
        win5_game.add_move(2, 1)
        win5_game.add_move(3, 1)
        win5_game.add_move(4, 1)
        win5_game.add_move(5, 1)
        expect(win5_game).to be_winner
      end

      it 'returns true for a column win' do
        win5_game.add_move(5, 1)
        win5_game.add_move(10, 1)
        win5_game.add_move(15, 1)
        win5_game.add_move(20, 1)
        win5_game.add_move(25, 1)
        expect(win5_game).to be_winner
      end

      it 'returns true for a / diagonal win' do
        win5_game.add_move(5, 1)
        win5_game.add_move(9, 1)
        win5_game.add_move(13, 1)
        win5_game.add_move(17, 1)
        win5_game.add_move(21, 1)
        expect(win5_game).to be_winner
      end

      it 'returns true for a \ diagonal win' do
        win5_game.add_move(1, 1)
        win5_game.add_move(7, 1)
        win5_game.add_move(13, 1)
        win5_game.add_move(19, 1)
        win5_game.add_move(25, 1)
        expect(win5_game).to be_winner
      end
    end

  end
end
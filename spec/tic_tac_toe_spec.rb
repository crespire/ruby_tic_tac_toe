# frozen_string_literal: true

require_relative '../main'

describe TicTacToe do
  describe '#initialize' do
    context 'when no parameters are passed to init' do
      subject(:game) { described_class.new }

      it 'makes a board of the right size' do
        blank = described_class::BLANK_VALUE
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
        blank = described_class::BLANK_VALUE
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

  describe '#full?' do
    context 'for the default board' do
      xit 'returns true when the board is full' do
      end

      xit 'returns false when the board has a spot open' do
      end
    end

    context 'for a custom board' do
      xit 'returns true when the board is full' do
      end

      xit 'returns false when the board has a free spot' do
      end
    end
  end

  describe '#loc_valid?' do
    context 'for the default board' do
      xit 'returns true when provided a location in bounds' do
        
      end

      xit 'returns false when provided an out of bounds location' do
        
      end
    end

    context 'for a larger, custom board' do
      xit 'returns true when provided an inbound location' do
        
      end

      xit 'returns false when provided an out of bounds location' do
        
      end
    end
  end

  describe '#loc_empty?' do
    context 'for the standard board' do
      xit 'returns true if the location is empty' do
      end

      xit 'returns false if the location is full' do
      end

      xit 'returns nil if the location is out of bounds' do
      end
    end
  end

  describe '#add_move' do
    context 'for the standard board' do
      xit 'adds a move to the board' do
      end

      xit 'adds a blank value if no input is specified' do
      end
    end
  end

  describe '#winner?' do
    context 'for the standard board' do
      xit 'returns true for a row win'do
        
      end

      xit 'returns true for a column win' do
        
      end

      xit 'returns true for a / diagonal win' do
        
      end

      xit 'returns true for a \ diagonal win' do
        
      end
    end


  end
end
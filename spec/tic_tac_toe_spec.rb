# frozen_string_literal: true

require_relative '../tic_tac_toe.rb'

describe TicTacToe do
  describe '#initialize' do
    # Make sure the board initializes as expected.

    context 'when no parameters are passed to init' do

      it 'makes a board of the right size' do
      end

      it 'generates the correct coordinates map' do
      end
      
      it 'has the correct value for max' do
      end
    end

    context 'when board size is specified' do
      it 'makes a board of the right size' do
      end

      it 'generates the correct coordinates map' do
      end

      it 'has the correct value for max' do
      end
    end
  end

  describe '#show_board' do
    # Primarily puts the board, no need to test
  end

  describe '#full?' do
    context 'for the default board' do
      it 'returns true when the board is full' do
      end

      it 'returns false when the board has a spot open' do
      end
    end

    context 'for a custom board' do
      it 'returns true when the board is full' do
      end

      it 'returns false when the board has a free spot' do
      end
    end
  end

  describe '#loc_valid?' do
    context 'for the default board' do
      it 'returns true when provided a location in bounds' do
        
      end

      it 'returns false when provided an out of bounds location' do
        
      end
    end

    context 'for a larger, custom board' do
      it 'returns true when provided an inbound location' do
        
      end

      if 'returns false when provided an out of bounds location' do
        
      end
    end
  end

  describe '#loc_empty?' do
    context 'for the standard board' do
      it 'returns true if the location is empty' do        
      end

      it 'returns false if the location is full' do
      end

      it 'returns nil if the location is out of bounds' do
      end
    end
  end

  describe '#add_move' do
    context 'for the standard board' do
      it 'adds a move to the board' do
      end

      it 'adds a blank value if no input is specified' do
      end
    end
  end

  describe '#winner?' do
    context 'for the standard board' do
      it 'returns true for a row win'do
        
      end

      it 'returns true for a column win' do
        
      end

      it 'returns true for a / diagonal win' do
        
      end

      it 'returns true for a \ diagonal win' do
        
      end
    end

    
  end
end
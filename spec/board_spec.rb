# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#full_column?' do
    subject(:board_column_full) { described_class.new(Array.new(6) { ['X'] + Array.new(6) }) }

    context 'when any row of the column is nil' do
      it 'is not full' do
        column_not_full = 1
        result = board_column_full.full_column?(column_not_full)
        expect(result).to be false
      end
    end

    context 'when all rows of the column is not nil' do
      it 'is full' do
        column_full = 0
        result = board_column_full.full_column?(column_full)
        expect(result).to be true
      end
    end
  end

  describe '#update_board' do
    subject(:board_update) { described_class.new([["\u26aa"] + Array.new(6)] + Array.new(5) { Array.new(7) }) }
    context 'when the column is empty' do
      it 'add piece at the first row of the column' do
        empty_column = 1
        piece = "\u26aa"
        expect { board_update.update_board(empty_column, piece) }.to change { board_update.instance_variable_get(:@board)[0][empty_column] }.from(nil).to(piece)
      end
    end

    context 'when the column is not empty' do
      it 'add piece at the next row of the column' do
        column_with_piece = 0
        piece = "\u26aa"
        expect { board_update.update_board(column_with_piece, piece) }.to change { board_update.instance_variable_get(:@board)[1][column_with_piece] }.from(nil).to(piece)
      end
    end
  end

  describe '#four_consecutive_in_row?' do
    context 'when there are four consecutive pieces in any row' do
      subject(:board_consecutive_row) { described_class.new([consecutive_row] + Array.new(5) { Array.new(7) }) }
      let(:consecutive_row) { Array.new(2) + Array.new(4, "\u26aa") + Array.new(1) }

      it 'returns true' do
        expect(board_consecutive_row).to be_four_consecutive_in_row
      end
    end

    context 'when there are no four consecutive pieces in any row' do
      subject(:board_not_consecutive_row) { described_class.new([not_consecutive_row] + Array.new(5) { Array.new(7) }) }
      let(:not_consecutive_row) { ["\u26aa", "\u26aa", "\u26ab", "\u26aa", "\u26aa", "\u26aa", nil] }

      it 'returns false' do
        expect(board_not_consecutive_row).not_to be_four_consecutive_in_row
      end
    end
  end

  describe '#four_consecutive_in_column?' do
    context 'when there are four consecutive pieces in any column' do
      subject(:board_cons_column) { described_class.new(([cons_col] + Array.new(6) { Array.new(6) }).transpose) }
      let(:cons_col) { Array.new(1) + Array.new(4, "\u26aa") + Array.new(1) }

      it 'returns true' do
        expect(board_cons_column).to be_four_consecutive_in_column
      end
    end

    context 'when there are no four consecutive pieces in any column' do
      subject(:board_no_cons_col) { described_class.new(([not_cons_col] + Array.new(6) { Array.new(6) }).transpose) }
      let(:not_cons_col) { ["\u26aa", "\u26aa", "\u26ab", "\u26aa", "\u26aa", "\u26aa"] }

      it 'returns false' do
        expect(board_no_cons_col).not_to be_four_consecutive_in_column
      end
    end
  end
end

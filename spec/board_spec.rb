# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#column_full?' do
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
end

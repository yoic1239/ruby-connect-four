# frozen_string_literal: true

require_relative '../lib/connect_four'

describe Game do
  describe '#play' do
  end

  describe '#player_input' do
    subject(:game_input) { described_class.new(board_input) }
    let(:board_input) { instance_double(Board) }

    context 'when user input is a valid column and it is not full' do
      before do
        valid_column = '7'
        allow(game_input).to receive(:gets).and_return(valid_column)
        allow(board_input).to receive(:full_column?).and_return(false)
      end

      it 'stops loop and does not display any error message' do
        invalid_input_msg = 'Invalid input! You should input a valid column.'
        full_column_msg = 'Column 7 is full. Please enter a column which is not full.'
        expect(game_input).not_to receive(:puts).with(invalid_input_msg)
        expect(game_input).not_to receive(:puts).with(full_column_msg)
        game_input.player_input
      end
    end

    context 'when user inputs an invalid column, then a valid column' do
      before do
        invalid_column = '8'
        valid_column = '3'
        allow(game_input).to receive(:gets).and_return(invalid_column, valid_column)
        allow(board_input).to receive(:full_column?).and_return(false)
      end

      it 'stops loop and displays invalid input message once' do
        invalid_input_msg = 'Invalid input! You should input a valid column.'
        full_column_msg = 'Column 3 is full. Please enter a column which is not full.'
        expect(game_input).to receive(:puts).with(invalid_input_msg).once
        expect(game_input).not_to receive(:puts).with(full_column_msg)
        game_input.player_input
      end
    end

    context 'when user inputs a column that is full, then a valid column that is not full' do
      before do
        full_column = '2'
        valid_column = '3'
        allow(game_input).to receive(:gets).and_return(full_column, valid_column)
        allow(board_input).to receive(:full_column?).and_return(true, false)
      end

      it 'stops loop and displays column full message' do
        invalid_input_msg = 'Invalid input! You should input a valid column.'
        full_column_msg = 'Column 2 is full. Please enter a column which is not full.'
        expect(game_input).not_to receive(:puts).with(invalid_input_msg)
        expect(game_input).to receive(:puts).with(full_column_msg).once
        game_input.player_input
      end
    end

    context 'when user inputs an invalid column, than a full column, then a valid column that is not full' do
      before do
        invalid_column = '9'
        full_column = '2'
        valid_column = '3'
        allow(game_input).to receive(:gets).and_return(invalid_column, full_column, valid_column)
        allow(board_input).to receive(:full_column?).and_return(true, false)
      end

      it 'stops loop and displays column full message' do
        invalid_input_msg = 'Invalid input! You should input a valid column.'
        full_column_msg = 'Column 2 is full. Please enter a column which is not full.'
        expect(game_input).to receive(:puts).with(invalid_input_msg).once
        expect(game_input).to receive(:puts).with(full_column_msg).once
        game_input.player_input
      end
    end
  end

  describe '#drop_piece' do
    subject(:game_drop) { described_class.new(board_drop) }
    let(:board_drop) { instance_double(Board) }
    let(:selected_column) { 0 }

    context 'when dropping a piece' do
      before do
        allow(game_drop).to receive(:player_input).and_return(selected_column)
      end

      it 'sends update_board to board' do
        piece = game_drop.instance_variable_get(:@curr_player).piece
        expect(board_drop).to receive(:update_board).with(selected_column, piece).once
        game_drop.drop_piece
      end
    end
  end

  describe '#win?' do
    subject(:game_win) { described_class.new(board_win) }
    let(:board_win) { instance_double(Board) }

    context 'when there are four consecutive pieces in a row' do
      before do
        allow(board_win).to receive(:four_consecutive_in_row?)
        allow(board_win).to receive(:four_consecutive_in_column?)
        allow(board_win).to receive(:four_consecutive_in_left_diagonal?)
        allow(board_win).to receive(:four_consecutive_in_right_diagonal?)
      end

      it 'sends four_consecutive_in_row to board' do
        expect(board_win).to receive(:four_consecutive_in_row?).once
        game_win.win?
      end

      it 'sends four_consecutive_in_column to board' do
        expect(board_win).to receive(:four_consecutive_in_column?).once
        game_win.win?
      end

      it 'sends four_consecutive_in_left_diagonal to board' do
        expect(board_win).to receive(:four_consecutive_in_left_diagonal?).once
        game_win.win?
      end

      it 'sends four_consecutive_in_right_diagonal to board' do
        expect(board_win).to receive(:four_consecutive_in_right_diagonal?).once
        game_win.win?
      end
    end

    context 'when there are 4 consecutive pieces in a row' do
      before do
        allow(board_win).to receive(:four_consecutive_in_row?).and_return(true)
      end

      it 'either player wins the game' do
        expect(game_win).to be_win
      end
    end

    context 'when there are 4 consecutive pieces in a column' do
      before do
        allow(board_win).to receive(:four_consecutive_in_row?).and_return(false)
        allow(board_win).to receive(:four_consecutive_in_column?).and_return(true)
      end

      it 'either player wins the game' do
        expect(game_win).to be_win
      end
    end

    context 'when there are 4 consecutive pieces in any left diagonal' do
      before do
        allow(board_win).to receive(:four_consecutive_in_row?).and_return(false)
        allow(board_win).to receive(:four_consecutive_in_column?).and_return(false)
        allow(board_win).to receive(:four_consecutive_in_left_diagonal?).and_return(true)
      end

      it 'either player wins the game' do
        expect(game_win).to be_win
      end
    end

    context 'when there are 4 consecutive pieces in any right diagonal' do
      before do
        allow(board_win).to receive(:four_consecutive_in_row?).and_return(false)
        allow(board_win).to receive(:four_consecutive_in_column?).and_return(false)
        allow(board_win).to receive(:four_consecutive_in_left_diagonal?).and_return(false)
        allow(board_win).to receive(:four_consecutive_in_right_diagonal?).and_return(true)
      end

      it 'either player wins the game' do
        expect(game_win).to be_win
      end
    end

    context 'when there are no 4 conseutive pieces in any direction' do
      subject(:game_not_win) { described_class.new(board_not_win) }
      let(:board_not_win) { instance_double(Board) }

      before do
        allow(board_not_win).to receive(:four_consecutive_in_row?).and_return(false)
        allow(board_not_win).to receive(:four_consecutive_in_column?).and_return(false)
        allow(board_not_win).to receive(:four_consecutive_in_left_diagonal?).and_return(false)
        allow(board_not_win).to receive(:four_consecutive_in_right_diagonal?).and_return(false)
      end

      it 'no one wins the game yet' do
        expect(game_not_win).not_to be_win
      end
    end
  end
end

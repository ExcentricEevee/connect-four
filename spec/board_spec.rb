require_relative '../lib/board'

describe Board do
    describe 'build_2d_array' do
        context 'when instantiating a 7x6 grid' do
            let(:new_board) { described_class.new }

            it 'should return an array of length 6' do
                solution = new_board.build_2d_array
                expect(solution.length).to eq(6)
            end

            matcher :all_be_7 do
                match { |grid| grid.all? { |ary| ary.length == 7 } }
            end

            it 'should have each array inside be length 7' do
                solution = new_board.build_2d_array
                expect(solution).to all_be_7
            end
        end
    end

    describe '#column_full?' do
        subject (:board_full) { described_class.new }
        #subject (:filled_game) { described_class.new(board_full, player1, player2) }
        
        context 'if the given index in the last array (top of grid) is filled' do
            before do
                #there has to be an easier way, but #each doesn't seem to work...
                board_full.grid[5][0] = 'R'
                board_full.grid[5][1] = 'R'
                board_full.grid[5][2] = 'R'
                board_full.grid[5][3] = 'R'
                board_full.grid[5][4] = 'R'
                board_full.grid[5][5] = 'R'
                board_full.grid[5][6] = 'R'
            end

            it 'should return true' do
                solution = board_full.column_full?(0)
                expect(solution).to be true
            end
        end
    end

    describe '#win_check' do
        subject(:winning_board) { described_class.new }

        context 'when four of the color Red appear in sequence' do
            it 'should return true' do
                board_row = "BRBRRRRB"
                solution = winning_board.win_check(board_row, 'R')
                expect(solution).to be true
            end
        end

        context 'when four of the color Black appear in sequence' do
            it 'should return true' do
                board_row = "BBRBBBBR"
                solution = winning_board.win_check(board_row, 'B')
                expect(solution).to be true
            end
        end

        context 'when neither Red or Black appear in squence' do
            it 'should return false for black' do
                board_row = "BRBRBRB"
                solution = winning_board.win_check(board_row, 'B')
                expect(solution).to be false
            end

            it 'should return false for red' do
                board_row = "BRBRBRB"
                solution = winning_board.win_check(board_row, 'R')
                expect(solution).to be false
            end
        end
    end

    describe '#four_in_a_row?' do
        subject(:board_hori) { described_class.new }

        context 'before calling #win_check' do
            before do
                board_hori.grid[0][0] = 'R'
                board_hori.grid[0][1] = 'R'
                board_hori.grid[0][2] = 'R'
                board_hori.grid[0][3] = 'R'
            end

            it 'should work with a method call??' do
                expect(board_hori.four_in_a_row?('R')).to be true
            end
        end
    end

    describe '#four_in_a_column?' do
        subject(:vert_board) { described_class.new }

        context 'when checking a column' do
            before do
                vert_board.grid[0][0] = 'R'
                vert_board.grid[1][0] = 'R'
                vert_board.grid[2][0] = 'R'
                vert_board.grid[3][0] = 'R'
            end

            it 'should transpose the arrays and check as you would a row' do
                expect(vert_board.four_in_a_column?('R')).to be true
            end
        end
    end

    describe '#diagonal_down' do
        subject(:diagonal_board) { described_class.new }

        context 'when checking a diagonal to the lower-right' do
            before do 
                diagonal_board.grid[0][0] = 'R'
                diagonal_board.grid[1][1] = 'R'
                diagonal_board.grid[2][2] = 'R'
                diagonal_board.grid[3][3] = 'R'
            end

            it 'should return true' do
                expect(diagonal_board.diagonal_down('R')).to be true
            end
        end
    end

    describe '#diagonal_up' do
        subject(:diagonal_board) { described_class.new }

        context 'when checking a diagonal to the upper-right' do
            before do 
                diagonal_board.grid[3][0] = 'R'
                diagonal_board.grid[2][1] = 'R'
                diagonal_board.grid[1][2] = 'R'
                diagonal_board.grid[0][3] = 'R'
            end
            it 'should return true' do
                expect(diagonal_board.diagonal_up('R')).to be true
            end
        end
    end

    describe '#four_in_a_diagonal?' do
        subject(:dang_board) { described_class.new }

        context 'when checking both diagonals and one is true' do
            before do
                allow(dang_board).to receive(:diagonal_up).and_return(true)
                allow(dang_board).to receive(:diagonal_down).and_return(false)
            end

            it 'should return true' do
                expect(dang_board.four_in_a_diagonal?('R')).to be true               
            end
        end

        context 'when neither diagonal checks are true' do
            before do
                allow(dang_board).to receive(:diagonal_up).and_return(false)
                allow(dang_board).to receive(:diagonal_down).and_return(false)
            end

            it 'should return false' do
                expect(dang_board.four_in_a_diagonal?('R')).to be false
            end
        end
    end
end
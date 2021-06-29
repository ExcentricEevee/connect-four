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
end
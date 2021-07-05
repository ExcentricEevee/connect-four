require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Game do
    #these are generic stand-ins; more specific instances will be used when necessary
    let(:board) { Board.new }
    let(:player1) { Player.new }
    let(:player2) { Player.new }

    #there is no need to test #initialize as it only assigns variables

    describe '#setup_players' do
        let(:new_player) { Player.new }
        let(:game_setup) { described_class.new(board, new_player, player2) }

        context "when asking for a player's name" do
            before do
                allow(game_setup).to receive(:puts)
                allow(game_setup).to receive(:gets).and_return('Arky')
            end

            it 'should set the returned value to player#name' do
                game_setup.setup_players
                expect(new_player.name).to eq('Arky')
            end
        end

        context 'after getting the player name' do
            before do
                allow(game_setup).to receive(:puts)
                allow(game_setup).to receive(:gets).and_return('Dusky')
            end

            it 'should set their color to player@color' do
                game_setup.setup_players
                expect(new_player.color).to eq('R')
            end
        end
    end

    describe '#switch_current_player' do
        subject(:game) { described_class.new(board, player1, player2) }

        context 'when the current player is nil' do
            it 'should set @current_player to @p1' do
                game.switch_current_player
                expect(game.current_player).to equal(game.p1)
            end
        end

        context 'when the current player is player1' do
            before do
                game.current_player = game.p1
            end

            it 'should set @current_player to @p2' do
                game.switch_current_player
                expect(game.current_player).to equal(game.p2)
            end
        end

        context 'when the current player is player 2' do
            before do
                game.current_player = game.p2
            end

            it 'should switch to player 1' do
                game.switch_current_player
                expect(game.current_player).to equal(game.p1)
            end
        end
    end

    describe '#take_turn' do
        let(:p1) { Player.new }
        let(:p2) { Player.new}
        subject(:game_turn) { described_class.new(board, p1, p2) }

        before do
            p1.set_color('R')
            p2.set_color('Y')
            game_turn.current_player = p1
        end

        context "when player input verifies true" do
            it 'should call #column_full?' do
                allow(game_turn).to receive(:puts)
                allow(game_turn).to receive(:verify_input).and_return(true)
                expect(board).to receive(:column_full?).once
                game_turn.take_turn
            end
        end

        context 'when player input verifies false twice and then true' do
            it 'should call #player_input three times, and #column_full? once' do
                allow(game_turn).to receive(:verify_input).and_return(false, false, true)

                expect(game_turn).to receive(:player_input).exactly(3).times
                expect(board).to receive(:column_full?).once
                game_turn.take_turn
            end
        end

        context 'when loop breaks on #column_full? being false' do
            it 'should call #select_column to place their color' do
                allow(game_turn).to receive(:puts)
                allow(game_turn).to receive(:verify_input).and_return(true)
                allow(board).to receive(:column_full?).and_return(false)

                expect(game_turn).to receive(:select_column).once
                game_turn.take_turn
            end
        end
    end

    describe '#verify_input' do
        let(:game_verify) { described_class.new(board, player1, player2) }

        context 'when the input is between 0 and 7' do
            it 'should return true' do
                input = '7'
                query = game_verify.verify_input(input)
                expect(query).to be true
            end
        end

        context 'when the input is a letter' do
            it 'should return false' do
                letter = 'a'
                query = game_verify.verify_input(letter)
                expect(query).to be false
            end
        end

        context 'when the input is a number, but out of range' do
            it 'should return false' do
                invalid_number = '8'
                query = game_verify.verify_input(invalid_number)
                expect(query).to be false
            end
        end
    end

    describe '#select_column' do
        let(:board_selection) { Board.new }
        let(:game_select) { described_class.new(board_selection, player1, player2) }

        context 'when a player picks column 0, and board is entirely empty' do
            before do
                game_select.p1.set_color('R')
            end

            it "should put the player's color on the bottom most row in the column" do
                input = 0
                color = game_select.p1.color
                game_select.select_column(input, color)
                expect(board_selection.grid[0][input]).to eq('R')
            end
        end

        context 'when a player picks column 0, and the first row is taken' do
            before do
                game_select.p1.set_color('B')
                board_selection.grid[0][0] = 'R'
            end

            it "should put the player's color on the second row of the column" do
                input = 0
                color = game_select.p1.color
                game_select.select_column(input, color)
                expect(board_selection.grid[1][input]).to eq('B')
            end
        end
    end
end
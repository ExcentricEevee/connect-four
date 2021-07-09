class Game
    attr_accessor :board, :p1, :p2, :current_player

    def initialize(board, player1, player2)
        @board = board
        @p1 = player1
        @p2 = player2
        #starts on p2 so it switches to p1 on first turn
        @current_player = p2
    end

    def start
        puts "Welcome to Connect Four!\n\n"
        setup_players
        play
    end

    def play
        until board.game_over?(current_player.color)
            switch_current_player
            board.show
            take_turn
        end

        finish_game
    end

    def setup_players
        puts "Player 1, what is your name?"
        p1.name = gets.chomp
        p1.color = 'R'
        puts "Welcome #{p1.name}! Your color is (R)ed.\n\n"

        puts "Player 2, what is your name?"
        p2.name = gets.chomp
        p2.color = 'B'
        puts "Hello to you too #{p2.name}! Your color is (B)lack.\n\n"
    end

    def switch_current_player
        current_player === p1 ? self.current_player = p2 : self.current_player = p1
    end

    def take_turn
        input = ''
        puts "#{current_player.name}, it's your turn."

        loop do
            input = player_input 

            if verify_input(input)
                if board.column_full?(input.to_i)
                    puts "This column is full, pick another."
                else
                    break
                end
            end
        end

        select_column(input.to_i, current_player.color)
    end

    def verify_input(input)
        return input.match?(/^[1-7]$/)
    end

    def select_column(input, color)
        #We are expecting the player to choose between 1-7, rather than 0-6
        input = input - 1
        board.grid.each do |row|
            if row[input] == ' '
                row[input] = color
                break
            end
        end
    end

    def finish_game
        board.show
        puts "#{current_player.name} wins!"
        current_player.update_score
        puts "#{p1.name}: #{p1.score} - #{p2.name}: #{p2.score}"
        confirm_play_again
    end

    def confirm_play_again
        puts "Would you like to play again? (y/n)"
        loop do
            input = gets.chomp
            if input == 'y'
                board.clear
                play
            elsif input == 'n'
                exit
            else
                puts "For the love of god just put 'y' or 'n' sobs"
            end
        end
    end

    private

    def player_input
        puts "Pick a number between 1 and 7:"
        gets.chomp
    end
end
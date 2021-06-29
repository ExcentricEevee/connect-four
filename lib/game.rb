class Game
    attr_accessor :board, :p1, :p2, :current_player

    def initialize(board, player1, player2)
        @board = board
        @p1 = player1
        @p2 = player2
        @current_player = nil
    end

    def start
        setup_players
        play
    end

    def play
        switch_current_player
        take_turn
    end

    def setup_players
        puts "Player 1, what is your name?"
        p1.name = gets.chomp
        p1.color = 'R'
        puts "Welcome #{p1.name}! Your color is Red.\n\n"

        puts "Player 2, what is your name?"
        p2.name = gets.chomp
        p2.color = 'Y'
        puts "Hello to you too #{p2.name}! Your color is Yellow.\n\n"
    end

    def switch_current_player
        current_player === p1 ? self.current_player = p2 : self.current_player = p1
    end

    def take_turn
        input = ''

        loop do
            input = player_input 

            if verify_input(input)
                if board.column_full?(input)
                    puts "This column is full, pick another."
                else
                    break
                end
            end
        end

        select_column(input.to_i, current_player.color)
    end

    def verify_input(input)
        return input.match?(/^[0-7]$/)
    end


    def select_column(input, color)
        board.grid.each do |row|
            if row[input] == nil
                row[input] = color
            end
        end
    end

    private

    def player_input
        puts "Pick a number between 0 and 7:"
        gets.chomp
    end
end
class Board
    attr_accessor :grid

    def initialize
        @grid = build_2d_array
    end

    #The first array is the bottom row of the grid, last array is top row
    def build_2d_array
        result = []
        6.times do
            result.push Array.new(7)
        end

        result
    end

    def show
        puts <<-HEREDOC
            #{grid}
        HEREDOC
    end

    def clear
       initialize 
    end

    def column_full?(input)
        grid[5][input] != nil
    end

    def game_over?(plr_color)
        four_in_a_row?(plr_color) || four_in_a_column?(plr_color) || four_in_a_diagonal?(plr_color)
    end

    def win_check(sequence, color)
        if color == 'R'
            sequence.include?('RRRR')
        elsif color == 'B'
            sequence.include?('BBBB')
        end
    end

    def four_in_a_row?(player_color)
        grid.each do |row|
            result = row.join("")
            return true if win_check(result, player_color)
        end

        return false
    end

    def four_in_a_column?(player_color)
        columns = grid.transpose
        columns.each do |column|
            result = column.join("")
            return true if win_check(result, player_color)
        end

        return false
    end

    def four_in_a_diagonal?(player_color)
        diagonal_down(player_color) || diagonal_up(player_color)
    end

    #consider making the above methods differently: perhaps #joining the arrays into strings-
    #- belongs to its own method, returning here to be passed into #win_check

    def diagonal_down(player_color)
        for row in 0..2
            container = []

            0.upto(3) do |column|
                container << grid[row+column][column]
            end

            result = container.join("")
            return true if win_check(result, player_color)
        end

        return false
    end

    def diagonal_up(player_color)
        for row in 3..5
            container = []

            0.upto(3) do |column|
                container << grid[row-column][column]
            end
            #binding.pry
            result = container.join("")
            return true if win_check(result, player_color)
        end

        return false
    end
end
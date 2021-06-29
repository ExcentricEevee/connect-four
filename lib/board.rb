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

    def column_full?(input)
        grid[5][input] != nil
    end
end
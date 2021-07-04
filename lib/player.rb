class Player
    attr_accessor :name, :color, :score
    
    def initialize
        @name = nil
        @color = nil
        @score = 0
    end

    def set_color(color)
        self.color = color
    end

    def update_score
        self.score += 1
    end
end
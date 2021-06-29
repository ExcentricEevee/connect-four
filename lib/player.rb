class Player
    attr_accessor :name, :color
    
    def initialize
        @name = nil
        @color = nil
    end

    def set_color(color)
        self.color = color
    end
end
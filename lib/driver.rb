require_relative 'game'
require_relative 'board'
require_relative 'player'

game = Game.new(Board.new, Player.new, Player.new)
game.start
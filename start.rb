require_relative 'game'
require_relative 'player'
require_relative 'dealer'
require_relative 'round'
require_relative 'deck'
require_relative 'card'
require_relative 'game_view'
require_relative 'round_view'
require_relative 'gameplay'

gameplay = Gameplay.new
gameplay.run_game

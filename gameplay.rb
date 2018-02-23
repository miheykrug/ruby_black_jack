class Gameplay
  def initialize
    @dealer = Dealer.new
    @player = Player.new
    @view = View.new
    @game = Game.new(player, dealer)
  end

  def run_game
    player.name = view.new_player
    loop do
      game.set_starting_values
      game_rounds
      view.show_game_result(game.game_winner.name) if game.game_winner
      break if view.ask_new_game == 'n'
    end
  end

  def game_rounds
    loop do
      Round.new(game).run_round
      break if game.game_winner
      break if view.ask_new_round == 'n'
    end
  end

  private

  attr_reader :game, :player, :dealer, :view
end

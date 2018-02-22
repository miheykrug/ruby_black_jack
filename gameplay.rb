class Gameplay
  def run_game
    self.dealer = Dealer.new
    self.player = Player.new
    self.view = View.new
    player.name = view.new_player

    loop do
      self.game = Game.new(player, dealer)
      Round.new(game).run_round
      view.show_game_result(game.game_winner.name) if game.game_winner
      break if view.ask_new_game == 'n'
    end
  end

  private

  attr_accessor :game, :player, :dealer, :view
end

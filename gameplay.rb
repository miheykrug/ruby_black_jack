class Gameplay
  include Game

  def initialize
    @dealer = Dealer.new
    @player = Player.new
    @view = GameView.new
  end

  def run_game
    player.name = view.new_player
    loop do
      set_starting_values
      game_rounds
      view.show_game_result(game_winner.name) if game_winner
      break if view.ask_new_game == 'n'
    end
  end

  def game_rounds
    loop do
      Round.new(player, dealer).run_round
      break if game_winner
      break if view.ask_new_round == 'n'
    end
  end

  private

  attr_reader :player, :dealer, :view
end

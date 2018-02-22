class Round
  def initialize(game)
    @game = game
  end

  def run_round
    self.view = View.new
    self.player = game.player
    self.dealer = game.dealer
    loop do
      set_starting_values
      game.first_deal
      game.bet
      view.show_steps_inf(player, game.sum_points(player), dealer)
      round_steps
      game.give_bank
      puts `clear`
      view.show_end_round_inf(player,
                              game.sum_points(player),
                              dealer,
                              game.sum_points(dealer),
                              game.round_winner)
      break if game.game_winner
      break if view.ask_new_round == 'n'
    end
  end

  private

  attr_reader :game
  attr_accessor :view, :player, :dealer

  def round_steps
    loop do
      view.player_step_puts(game.player.name).each { |str| puts str }
      player_step
      dealer_step
      puts `clear`
      view.show_steps_inf(player, game.sum_points(player), dealer)
      break if player.open_cards && dealer.open_cards
    end
  end

  def set_starting_values
    game.deck = Deck.new
    game.bank = 0
    player.cards = []
    player.open_cards = false
    dealer.cards = []
    dealer.open_cards = false
  end

  def player_step
    loop do
      step_index = gets.chomp
      case step_index
      when '1'
        break
      when '2'
        player.open_cards = true
        game.give_card(player)
        break
      when '3'
        player.open_cards = true
        break
      else
        puts 'Неверный ввод'
      end
    end
  end

  def dealer_step
    game.give_card(dealer) if game.sum_points(dealer) < 17
    dealer.open_cards = true
  end
end

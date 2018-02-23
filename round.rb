class Round
  include Game

  def initialize(player, dealer)
    @view = RoundView.new(player, dealer)
    @player = player
    @dealer = dealer
    set_starting_values
  end

  def run_round
    first_deal
    take_bets
    view.show_steps_inf(sum_points(player))
    round_steps
    give_bank
    player_points = sum_points(player)
    dealer_points = sum_points(dealer)
    winner = round_winner
    view.show_end_round_inf(player_points, dealer_points, winner)
  end

  private

  attr_accessor :view, :player, :dealer, :bank, :deck

  def round_steps
    loop do
      view.player_step_menu
      player_step
      dealer_step
      view.show_steps_inf(sum_points(player))
      break if player.open_cards && dealer.open_cards
    end
  end

  def set_starting_values
    self.deck = Deck.new
    self.bank = 0
    player.cards = []
    player.open_cards = false
    dealer.cards = []
    dealer.open_cards = false
  end

  def player_step
    loop do
      step_index = view.player_choise
      case step_index
      when '1'
        break
      when '2'
        player.open_cards = true
        give_card(player)
        break
      when '3'
        player.open_cards = true
        break
      else
        view.invalid_input
      end
    end
  end

  def dealer_step
    give_card(dealer) if sum_points(dealer) < 17
    dealer.open_cards = true
  end
end

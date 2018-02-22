class Gameplay
  attr_accessor :game, :player, :dealer
  attr_reader :view
  def initialize
    @dealer = Dealer.new
    @player = Player.new
    @view = View.new
    @player.name = @view.new_player
  end

  def game_steps
    loop do
      self.game = Game.new(player, dealer)
      deal
      break if view.ask_new_game == 'n'
    end
  end

  def deal
    loop do
      start_round
      game.first_deal
      game.bet
      view.show_cards(player)
      puts game.sum_points(player)
      view.hide_cards(dealer)
      round_steps
      puts `clear`
      view.show_cards(player)
      puts game.sum_points(player)
      view.show_cards(dealer)
      puts game.sum_points(dealer)
      view.show_round_result(game.round_winner)
      game.give_bank
      view.show_bank(player)
      view.show_bank(dealer)
      view.end_game(game.game_winner) if game.game_winner
      break if game.game_winner
      break if view.ask_new_round == 'n'
    end
  end

  def round_steps
    loop do
      view.player_step_puts(player.name).each { |str| puts str }
      player_step
      dealer_step
      puts `clear`
      view.show_cards(player)
      puts game.sum_points(player)
      view.hide_cards(dealer)
      break if player.open_cards && dealer.open_cards
    end
  end

  def start_round
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

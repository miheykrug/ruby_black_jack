class Game
  DECK = [
    '2♣', '3♣', '4♣', '5♣', '6♣', '7♣', '8♣', '9♣', '10♣', 'K♣', 'Q♣', 'J♣', 'A♣',
    '2♥', '3♥', '4♥', '5♥', '6♥', '7♥', '8♥', '9♥', '10♥', 'K♥', 'Q♥', 'J♥', 'A♥',
    '2♦', '3♦', '4♦', '5♦', '6♦', '7♦', '8♦', '9♦', '10♦', 'K♦', 'Q♦', 'J♦', 'A♦',
    '2♠', '3♠', '4♠', '5♠', '6♠', '7♠', '8♠', '9♠', '10♠', 'K♠', 'Q♠', 'J♠', 'A♠'
  ].freeze

  BET = 10

  attr_accessor :player, :dealer, :bank, :deck

  def initialize
    @dealer = Player.new('dealer')
    @deck = DECK.shuffle
    @bank = 0
  end

  def player_step_puts
    ["#{player.name}, Ваш ход", '1 - Пропустить',
     '2 - Добавить карту', '3 - Открыть карты']
  end

  # def player_step_methods
  #   {'1' => dealer_step}
  # end

  def new_player
    puts 'Представьтесь, пожалуйста'
    self.player = Player.new(gets.chomp)
  end

  def give_card(player)
    player.cards << deck.delete(deck.sample) if player.cards.length < 3
  end

  def first_deal
    puts `clear`
    2.times do
      give_card(player)
      give_card(dealer)
    end

    bet
    player.show_cards
    dealer.hide_cards
  end

  def bet
    self.bank = BET * 2
    player.bank -= BET
    dealer.bank -= BET
  end

  def player_step
    player_step_puts.each { |str| puts str }
    loop do
      step_index = gets.chomp
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
        puts 'Неверный ввод'
      end
    end
  end

  def dealer_step
    give_card(dealer) if dealer.sum_points < 17
    dealer.open_cards = true
    # player_step
  end

  def round_steps
    loop do
      player_step
      dealer_step
      puts `clear`
      player.show_cards
      dealer.hide_cards
      break if player.open_cards && dealer.open_cards
    end
  end

  def show_round_results
    player.show_cards
    dealer.show_cards
    round_result
    puts "Банк диллера: #{dealer.bank}"
    puts "Банк #{player.name}: #{player.bank}"
  end

  def game
    new_player
    loop do
      first_deal
      round_steps
      puts `clear`
      show_round_results
      end_round
      end_game if game_winner
      puts 'Хотите сыграть заново? y/n'
      anew = gets.chomp.downcase
      break if anew == 'n'
    end
  end

  def round_winner
    if (player.sum_points > 21 && dealer.sum_points > 21) || (player.sum_points == dealer.sum_points)
      nil
    elsif player.sum_points > 21
      dealer
    elsif dealer.sum_points > 21
      player
    else
      player.sum_points > dealer.sum_points ? player : dealer
    end
  end

  def round_result
    if round_winner
      puts "Победил #{round_winner.name}!!!"
      round_winner.bank += bank
    else
      puts 'Ничья'
      player.bank += bank / 2
      dealer.bank += bank / 2
    end
  end

  def end_round
    self.bank = 0
    self.deck = DECK.shuffle
    player.cards = []
    player.open_cards = false
    dealer.cards = []
    dealer.open_cards = false
  end

  def game_winner
    return dealer if player.bank <= 0
    return player if dealer.bank <= 0
  end

  def end_game
    puts "-------!!!!! В игре выиграл #{game_winner.name} !!!!!--------"
    player.bank = dealer.bank = Player::BANK
  end
end

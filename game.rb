class Game
  BET = 10
  PLAYER_BANK = 100

  attr_accessor :bank, :deck, :player, :dealer

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @player.bank = @dealer.bank = PLAYER_BANK
  end

  def first_deal
    puts `clear`
    2.times do
      give_card(player)
      give_card(dealer)
    end
  end

  def give_card(player)
    player.cards << deck.cards.delete(deck.cards[0]) if player.cards.length < 3
  end

  def bet
    self.bank = BET * 2
    player.bank -= BET
    dealer.bank -= BET
  end

  def sum_points(player)
    cards_value = player.cards.map(&:value)
    loop do
      sum = cards_value.reduce(:+)
      return sum unless sum > 21
      return sum unless cards_value.include?(11)
      ace_index = cards_value.find_index { |card| card == 11 }
      cards_value[ace_index] = 1
    end
  end

  def round_winner
    if sum_points(player) > 21 && sum_points(dealer) > 21 # || (sum_points(player) == sum_points(dealer))
      nil
    elsif sum_points(player) > 21
      dealer
    elsif sum_points(dealer) > 21
      player
    elsif sum_points(player) > sum_points(dealer)
      player
    elsif sum_points(player) < sum_points(dealer)
      dealer
    end
  end

  def give_bank
    if round_winner
      round_winner.bank += bank
    else
      player.bank += bank / 2
      dealer.bank += bank / 2
    end
  end

  def game_winner
    return dealer if player.bank <= 0
    return player if dealer.bank <= 0
  end
end

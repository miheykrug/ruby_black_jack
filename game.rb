class Game
  DECK = ["2♣", "3♣", "4♣", "5♣", "6♣", "7♣", "8♣", "9♣", "10♣", "K♣", "Q♣", "J♣", "A♣",
          "2♥", "3♥", "4♥", "5♥", "6♥", "7♥", "8♥", "9♥", "10♥", "K♥", "Q♥", "J♥", "A♥",
          "2♦", "3♦", "4♦", "5♦", "6♦", "7♦", "8♦", "9♦", "10♦", "K♦", "Q♦", "J♦", "A♦",
          "2♠", "3♠", "4♠", "5♠", "6♠", "7♠", "8♠", "9♠", "10♠", "K♠", "Q♠", "J♠", "A♠"]

  BET = 10
  attr_reader :deck
  attr_accessor :player, :dealer, :bank

  def initialize
    @dealer = Player.new("dealer")
    @deck = DECK.shuffle
    @bank = 0
  end

  def new_player
    puts "Представьтесь, пожалуйста"
    self.player = Player.new(gets.chomp)
  end

  def give_card(player)
    player.cards << deck.delete(deck.sample)
  end

  def first_deal
    2.times do
      give_card(player)
      give_card(dealer)
    end
  end

  def bet
    self.bank = BET * 2
    player.bank -= BET
    dealer.bank -= BET
  end

  def player_step
    loop do
      break if player.open_cards
      puts "#{player.name}, Ваш ход"
      puts "1 - Пропустить"
      puts "2 - Добавить карту"
      puts "3 - Открыть карты"

      step_index = gets.chomp
      case step_index
      when "1"
        break
      when "2"
        player.open_cards = true
        return give_card(player)
      when "3"
        player.open_cards = true
        break
      end
    end
  end

  def dealer_step
    give_card(dealer) if dealer.sum_points < 17
    dealer.open_cards = true
  end

  def game
    new_player
    loop do
      first_deal
      bet
      dealer.show_cards
      player.show_cards
      loop do
        player_step
        player.show_cards

        dealer_step
        dealer.show_cards

        if player.open_cards && dealer.open_cards
          break
        end
      end
      result
      puts "Банк диллера: #{dealer.bank}"
      puts "Банк #{player.name}: #{player.bank}"
      end_game
      puts player.open_cards
      puts "Хотите сыграть заново? y/n #{player.open_cards}"
      anew = gets.chomp.downcase
      break if anew == 'n'
    end
  end

  def winner
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

  def result
    if winner
      puts "Победил #{winner.name}!!!"
      winner.bank += bank
    else
      puts "Ничья"
      player.bank += bank/2
      dealer.bank += bank/2
    end
  end

  def end_game
    self.bank = 0
    player.cards = []
    player.open_cards = false
    dealer.cards = []
    dealer.open_cards = false
  end
end

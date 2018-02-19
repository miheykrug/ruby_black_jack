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
    2.tymes do
      give_card(player)
      give_card(dealer)
    end
  end

  def bet
    self.bank = BET * 2
    player.bank -= 10
    dealer.bank -= 10
  end


end

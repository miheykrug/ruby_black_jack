class Player
  attr_accessor :cards, :open_cards, :bank, :name

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    @points = 0
    @open_cards = false
  end

  def sum_points
    cards_value = cards.map { |card| card_value(card) }
    loop do
      sum = cards_value.reduce(:+)
      return sum unless sum > 21
      return sum unless cards_value.include?(11)
      ace_index = cards_value.find_index { |card| card == 11 }
      cards_value[ace_index] = 1
    end
  end

  def card_value(card)
    value = card.to_i
    return value if value > 0
    card[0] == 'A' ? 11 : 10
  end

  def show_cards
    puts "Карты #{name}"
    cards.each { |card| print "[#{card}]"}
    puts sum_points
  end
end

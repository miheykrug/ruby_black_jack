class Deck
  SUITS = %w[♣ ♥ ♦ ♠].freeze
  CARD_NAMES  = %w[2 3 4 5 6 7 8 9 10 J D K A].freeze
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].freeze
  attr_reader :cards
  def initialize
    @cards = []
    create_deck
    @cards.shuffle!
  end

  def create_deck
    SUITS.each do |suit|
      CARD_NAMES.each_with_index do |name, index|
        @cards << Card.new(name, suit, CARD_VALUES[index])
      end
    end
  end
end

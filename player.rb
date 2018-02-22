class Player
  attr_accessor :cards, :open_cards, :bank, :name

  def initialize
    @cards = []
    @open_cards = false
  end
end

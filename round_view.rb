class RoundView
  def initialize(player, dealer)
    @player = player
    @dealer = dealer
  end

  def player_step_puts
    ["#{player.name}, Ваш ход", '1 - Пропустить',
     '2 - Добавить карту', '3 - Открыть карты']
  end

  def player_step_menu
    player_step_puts.each { |str| puts str }
  end

  def show_steps_inf(player_points)
    puts `clear`
    show_cards(player)
    show_points(player_points)
    hide_cards(dealer)
  end

  def show_end_round_inf(player_points, dealer_points, winner)
    puts `clear`
    show_cards(player)
    show_points(player_points)
    show_cards(dealer)
    show_points(dealer_points)
    show_round_result(winner)
    show_bank(player)
    show_bank(dealer)
  end

  def invalid_input
    puts 'Неверный ввод'
  end

  def player_choise
    gets.chomp
  end

  private

  attr_reader :player, :dealer

  def show_cards(player)
    puts "Карты #{player.name}"
    card_string = ''
    player.cards.each { |card| card_string += "[#{card.name}#{card.suit}]" }
    puts card_string
  end

  def hide_cards(player)
    puts "Карты #{player.name}"
    card_string = '[*]' * player.cards.length
    puts card_string
  end

  def show_points(points)
    puts "очки: #{points}"
  end

  def show_round_result(winner)
    winner ? (puts "Победил #{winner.name}!!!") : (puts 'Ничья')
  end

  def show_bank(player)
    puts "Банк #{player.name}: #{player.bank}"
  end

  def line
    puts '___________________________________________'
  end
end

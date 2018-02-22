class View
  def new_player
    puts 'Представьтесь, пожалуйста'
    gets.chomp
  end

  def player_step_puts(name)
    ["#{name}, Ваш ход", '1 - Пропустить',
     '2 - Добавить карту', '3 - Открыть карты']
  end

  def show_steps_inf(player, player_points, dealer)
    show_cards(player)
    show_points(player_points)
    hide_cards(dealer)
  end

  def show_end_round_inf(player, player_points, dealer, dealer_points, round_winner)
    show_cards(player)
    show_points(player_points)
    show_cards(dealer)
    show_points(dealer_points)
    show_round_result(round_winner)
    show_bank(player)
    show_bank(dealer)
  end

  def show_game_result(name)
    line
    puts "-------!!!!! В игре выиграл #{name} !!!!!--------"
  end

  def ask_new_round
    line
    puts 'Хотите продолжить игру?'
    puts '- для продолжения сделайте любой ввод'
    puts '- для завершения игры введите "n"'
    gets.chomp.downcase
  end

  def ask_new_game
    line
    puts 'Хотите сыграть заново? y/n'
    puts '- для продолжения сделайте любой ввод'
    puts '- для выхода введите "n"'
    gets.chomp.downcase
  end

  private

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

  def show_round_result(round_winner)
    round_winner ? (puts "Победил #{round_winner.name}!!!") : (puts 'Ничья')
  end

  def show_bank(player)
    puts "Банк #{player.name}: #{player.bank}"
  end

  def line
    puts '___________________________________________'
  end
end

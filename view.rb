class View
  def new_player
    puts 'Представьтесь, пожалуйста'
    gets.chomp
  end

  def player_step_puts(player_name)
    ["#{player_name}, Ваш ход", '1 - Пропустить',
     '2 - Добавить карту', '3 - Открыть карты']
  end

  def show_cards(player)
    puts "Карты #{player.name}"
    card_string = ''
    player.cards.each { |card| card_string += "[#{card.name}#{card.suit}]" }
    puts card_string
  end

  def hide_cards(player)
    puts 'Карты дилера'
    card_string = '[*]' * player.cards.length
    puts card_string
  end

  def show_round_result(winner)
    winner ? (puts "Победил #{winner.name}!!!") : (puts 'Ничья')
  end

  def end_game(game_winner)
    puts "-------!!!!! В игре выиграл #{game_winner.name} !!!!!--------"
  end

  def show_bank(player)
    puts "Банк #{player.name}: #{player.bank}"
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

  def line
    puts '___________________________________________'
  end
end

class GameView
  def new_player
    puts 'Представьтесь, пожалуйста'
    gets.chomp
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
    puts 'Хотите начать Новую игру? y/n'
    puts '- для продолжения сделайте любой ввод'
    puts '- для выхода введите "n"'
    gets.chomp.downcase
  end

  private

  def line
    puts '___________________________________________'
  end
end

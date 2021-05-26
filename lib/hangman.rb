require_relative 'game_state'

class Hangman
  def filter_words(words, pattern, used_letters)
    char_class = if used_letters.empty?
                   '.'
                 else
                   '[^'+used_letters.join+']'
                 end
    regexp = Regexp.new('^'+pattern.gsub('_',char_class)+'$')
    words.grep regexp
  end

  def best_move(game_state)
    game_state.moves.max_by do |move|
      pattern = move.pattern
      filter_words(@all_words, pattern, game_state.used_letters).length
    end
  end

  def load_words
    words = File.open(ENV['HANGMAN_DICTIONARY']).map(&:strip).grep %r(^[a-z]{8}$)
  end

  def initialize
    @all_words = load_words
    nil
  end

  def game
    pattern = '________'
    game_state = GameState.new(@all_words, pattern, [], nil, :player)

    used_letters = []
    while(game_state.pattern =~ /_/) do
      puts game_state.to_s
      guess = ''
      until move = game_state.moves.select { |m| m.guess == guess }.first
        print 'Your guess? '
        guess = gets.strip
      end

      require 'byebug'; debugger
      game_state = game_state.apply(move)

      computer_move = best_move(game_state)
      game_state = game_state.apply(computer_move)
    end

    puts "#{game_state.pattern} - you got it!"
  end

  def do_guess(game_state)

    [new_pattern, game_state.used_letters.sort.uniq]
  end
end

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

  def best_option(words, options, used_letters)
    options.max_by do |pattern|
      filter_words(words, pattern, used_letters).length
    end
  end

  def load_words
    words = File.open(ENV['HANGMAN_DICTIONARY']).map(&:strip).grep %r(^[a-z]+$)
  end

  def initialize
    @all_words = load_words
    nil
  end

  def game
    pattern = '________'
    used_letters = []
    while(pattern =~ /_/) do
      puts "#{pattern} (used: #{used_letters.sort.join})"

      guess = ''
      until guess =~ /^[a-z]$/ && !used_letters.include?(guess)
        print 'Your guess? '
        guess = gets.strip
      end

      (pattern, used_letters) = do_guess(guess, pattern, used_letters)
    end

    puts "#{pattern} - you got it!"
  end

  def do_guess(guess, pattern, used_letters)
    words = filter_words(@all_words, pattern, used_letters)

    new_used_letters = used_letters.dup
    new_used_letters << guess

    game_state = GameState.new(words, pattern, used_letters, guess, :computer)
    options = game_state.moves.map { |m| m.pattern }
    new_pattern = best_option(words, options, new_used_letters)

    [new_pattern, new_used_letters.sort.uniq]
  end
end

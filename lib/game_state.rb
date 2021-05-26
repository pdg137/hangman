require_relative 'move.rb'

class GameState
  attr_reader :used_letters, :pattern

  def initialize(words, pattern, used_letters, guess, turn)
    raise 'computer does not "guess"' if guess && turn == :player
    raise 'player must "guess"' if !guess && turn == :computer

    @words = words
    @pattern = pattern
    @used_letters = used_letters
    @guess = guess
    @turn = turn
  end

  def to_s
    "#{pattern} (used: #{used_letters.sort.join})"
  end

  def inspect
    to_s
  end

  def moves
    if :player == @turn
      possible_guesses.map { |g| Move.guess(g) }
    else
      possible_patterns.map { |p| Move.pattern(p) }
    end
  end

  def apply(move)
    case @turn
    when :player
      apply_player(move)
    when :computer
      apply_computer(move)
    end
  end

  private

  def possible_guesses
    ('a'..'z').to_a - @used_letters
  end

  def filter_words
    # TODO: allow the guessed letter on the computer's turn
    char_class = if @used_letters.empty?
                   '.'
                 else
                   '[^'+@used_letters.join+']'
                 end
    regexp = Regexp.new('^'+@pattern.gsub('_',char_class)+'$')
    @words.grep regexp
  end

  def possible_patterns
    filter_words.map do |word|
      p = @pattern.dup
      word.length.times do |i|
        if word[i] == @guess
          p[i] = @guess
        end
      end
      p
    end.sort.uniq
  end

  def apply_player(move)
    raise if !move.guess
    new_used_letters = @used_letters.dup
    new_used_letters << move.guess

    GameState.new(@words, pattern, new_used_letters.sort!, move.guess, :computer)
  end

  def apply_computer(move)
    raise if !move.pattern

    GameState.new(@words, move.pattern, @used_letters, nil, :player)
  end
end

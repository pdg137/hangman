require_relative 'move.rb'

class GameState
  def initialize(words, pattern, used_letters, guess, turn)
    raise 'computer does not "guess"' if guess && turn == :player
    raise 'player must "guess"' if !guess && turn == :computer

    @words = words
    @pattern = pattern
    @used_letters = used_letters
    @guess = guess
    @turn = turn
  end

  def moves
    if :player == @turn
      possible_guesses
    else
      possible_patterns.map { |p| Move.pattern(p) }
    end
  end

  private

  def possible_patterns
    @words.map do |word|
      p = @pattern.dup
      word.length.times do |i|
        if word[i] == @guess
          p[i] = @guess
        end
      end
      p
    end.sort.uniq
  end
end

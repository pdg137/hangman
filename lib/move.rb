class Move
  attr_reader :guess, :pattern

  def self.guess(guess)
    Move.new(nil, guess)
  end

  def self.pattern(pattern)
    Move.new(pattern, nil)
  end

  def to_s
    if @pattern
      "respond with #{@pattern}"
    else
      "guess #{@guess}"
    end
  end

  private
  def initialize(pattern, guess)
    raise 'only one of pattern, guess allowed' if @pattern && @guess
    @pattern = pattern
    @guess = guess
  end
end


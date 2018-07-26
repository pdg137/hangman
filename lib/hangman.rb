class Hangman
  def filter_words(words, pattern, used_letters)
    char_class = if used_letters.empty?
                   '.'
                 else
                   '[^'+used_letters.join+']'
                 end
    regexp = Regexp.new(pattern.gsub('_',char_class))
    words.grep regexp
  end

  def options(pattern, guess)
    [pattern] +
      pattern.length.times.collect do |i|
      if pattern[i] == '_'
        pattern.slice(0,i) + guess + pattern.slice(i+1,pattern.length-1)
      else
        nil
      end
    end.compact
  end
end

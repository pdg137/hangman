class Hangman
  def filter_words(words, pattern, missing_letters)
    char_class = if missing_letters.empty?
                   '.'
                 else
                   '[^'+missing_letters.join+']'
                 end
    regexp = Regexp.new(pattern.gsub('_',char_class))
    words.grep regexp
  end
end

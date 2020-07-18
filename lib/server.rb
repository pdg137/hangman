require 'sinatra'
require_relative 'hangman.rb'

hangman = Hangman.new

def safe_param(key, regex)
  raise "bad value #{params[key]}" if !(params[key] =~ regex)
  params[key]
end

get '/hangman' do
  if params[:pattern]
    used_letters = safe_param(:used, /^[a-z]*$/).chars
    guess = safe_param(:guess, /^[a-z]$/)
    pattern = safe_param(:pattern, /^[a-z_]+$/)
    (new_pattern, new_used_letters) = hangman.do_guess(pattern, used_letters, guess)
  else
    new_used_letters = []
    new_pattern = '_______'
  end

  <<END
<form>
Word: <input type="text" name="pattern" value="#{new_pattern}"><br>
Used: <input type="text" name="used" value="#{new_used_letters.join}"><br>
Your guess: <input type="text" name="guess" autofocus="true"><br>
<input type="submit">
</form>
END
end

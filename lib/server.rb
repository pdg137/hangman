require 'sinatra'
require_relative 'hangman.rb'

set :bind, '0.0.0.0'
hangman = Hangman.new

def safe_param(key, regex)
  raise "bad value #{params[key]}" if !(params[key] =~ regex)
  params[key]
end

get '/hangman' do
  if params[:pattern]
    used_letters = safe_param(:used, /^[a-z]*$/).chars
    guess = safe_param(:guess, /^[a-zA-Z]$/).downcase
    pattern = safe_param(:pattern, /^[a-z_]+$/)
    (new_pattern, new_used_letters) = hangman.do_guess(pattern, used_letters, guess)
  else
    new_used_letters = []
    new_pattern = '_______'
  end

  <<END
<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset='utf-8'>
<link href='https://plus.google.com/106874607765859343033' rel='publisher'>
<meta content='width=device-width, initial-scale=1' name='viewport'>
</head>

<style>
body { font-size: 22px; line-height: 2em; font-family: sans;}
input[type=text] { font-family: Courier New, monospace;}
input { font-size: 22px; }
</style>

<body>

<form>
Word: <input type="text" name="pattern" value="#{new_pattern}" style="width: 100px;"><br>
Used: <input type="text" name="used" value="#{new_used_letters.join}" style="width: 350px;"><br>
Your guess: <input type="text" name="guess" autofocus="true" maxlength=1 style="width: 2em;" autocomplete="off"><br>
<input type="submit">
</form>

<a href="?">New game</a>
</body>
</html>
END
end

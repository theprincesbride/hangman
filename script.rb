require 'pry-byebug'
def game()
dictionary = []

File.open('dictionary.txt', 'r') do |f|
    f.each_line do |line|
        word = line.chomp
        if word.length >= 5 && word.length <= 12
            dictionary.push(word)
        end
    end
end
    secret_word = dictionary.sample
    player = Player.new
    hangman = Hangman.new
    puts hangman.hangman_display
    puts "Welcome to Hangman!  You will be attempting to guess the secret word within 11 turns by guessing 1 letter at a time."
    puts "When the floor appears below the hangman, you lose!"
    secret_word_hidden = hide_secret_word(secret_word)
    puts secret_word
    puts "Word to guess: #{secret_word_hidden}"
end


def hide_secret_word(word)
    new_string = ''
    i = 0
    while i < word.length do
        new_string += '_ '
        i += 1
    end
    new_string
end


class Player
    attr_accessor :letters, :guesses, :correct_letters, :wrong_letters
    def initialize()
        @letters = 'abcdefghijklmnopqrstuvwxyz'
        @guesses = 11
        @correct_letters = []
        @wrong_letters = []
    end
end

class Hangman
    attr_accessor :hangman_display, :hangman_tracker
    def initialize()
    @hangman_display = [
    [" ______________________________"],
    ["|                             |"],
    ["|            [   ]            |"],
    ["|              |              |"],
    ["|          --- | ---          |"],
    ["|              |              |"],
    ["|              |              |"],
    ["|             / \\             |"],
    ["|            /   \\            |"],
    ["|          _/     \\_          |"],
    ["|_____________________________|"]
    ]
    end
    @hangman_tracker = []

end

game()

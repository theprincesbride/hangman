require 'pry-byebug'
def game()
    word_bank = SecretWord.new
    word_bank.define_dictionary()
    secret_word = word_bank.secret_word()
    secret_word_hidden = word_bank.secret_word_hidden(secret_word)
    player = Player.new
    hangman = Hangman.new
    puts hangman.hangman_display
    puts "Welcome to Hangman!  You will be attempting to guess the secret word within 11 turns by guessing 1 letter at a time."
    puts "When the floor appears below the hangman, you lose!"
    puts secret_word
    player.display_values(secret_word_hidden, player.guesses, player.correct_letters, player.wrong_letters)
end


class Player
    attr_accessor :letters, :guesses, :correct_letters, :wrong_letters
    def initialize()
        @letters = 'abcdefghijklmnopqrstuvwxyz'
        @guesses = 11
        @correct_letters = []
        @wrong_letters = []
    end
    def display_values(value1, value2, value3, value4)
        puts "Word to guess: #{value1}"
        puts "Number of guesses left: #{value2}"
        puts "Correct letters guessed: #{value3}"
        puts "Wrong letters guessed #{value4}"
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

class SecretWord
    attr_accessor :dictionary
    def initialize()
        @dictionary = []
    end
    def define_dictionary()
        File.open('dictionary.txt', 'r') do |f|
            f.each_line do |line|
                word = line.chomp
                if word.length >= 5 && word.length <= 12
                    @dictionary.push(word)
                end
            end
        end
    end
    def secret_word()
        word = @dictionary.sample
    end
    def secret_word_hidden(word)
        new_string = ''
        i = 0
        while i < word.length do
            new_string += '_ '
            i += 1
        end
        new_string
    end
end


game()

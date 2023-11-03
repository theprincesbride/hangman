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

    until player.guesses == 0
    player.display_values(secret_word_hidden, player.guesses, player.correct_letters, player.wrong_letters)
    letter = player.get_letter()
    result = player.right_letter?(letter, secret_word)
    if result == true
        secret_word_hidden = player.true_action(letter, secret_word, secret_word_hidden)
    end
    end
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
        sleep 2
    end
    def get_letter()
        puts "Please choose a letter.  The secret word does not include numbers or symbols."
        letter = gets
        letter = letter.chomp.downcase
        if !@letters.include?(letter)
            get_letter()
        elsif @letters.include?(letter)
            letter
        end
    end

    def right_letter?(letter, secret_word) #need to include action for a repeated selection
        if secret_word.include?(letter)
            puts "Congratulations!  You chose one of the correct letters!"
            sleep 2
            true
        elsif !secret_word.include?(letter)
            false
        end
    end

    def true_action(letter, secret_word, secret_word_hidden)
        secret_array = secret_word_hidden.split(' ')
        i = 0
        while i < secret_word.length
                if secret_word[i] == letter && !@correct_letters.include?(letter)
                    @correct_letters.push(letter)
                    secret_array.delete_at(i)
                    secret_array.insert(i, letter)
                    i += 1
                elsif secret_word[i] == letter
                    secret_array.delete_at(i)
                    secret_array.insert(i, letter)
                    i += 1
                else
                    i += 1
                end

            end
            @guesses -= 1
            secret_array.join(' ')
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

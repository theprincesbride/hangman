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
    until player.guesses == 0
    player.display_values(secret_word_hidden, player.guesses, player.correct_letters, player.wrong_letters)
    letter = player.get_letter()
    result = player.right_letter?(letter, secret_word)
    if player.correct_letters.include?(letter) || player.wrong_letters.include?(letter)
        puts "You've already chosen that letter!  Please choose a different letter."
        sleep 2
    elsif result == true && !player.correct_letters.include?(letter) && !player.wrong_letters.include?(letter)
        secret_word_hidden = player.true_action(letter, secret_word, secret_word_hidden)
        puts hangman.hangman_tracker
        if !secret_word_hidden.include?('_')
            puts "Congratulations!  Your guessed the secret word within 11 guesses!  You win!"
            puts "W---(^_^)---W"
            sleep 2
            puts "Do you want to start a new game?"
            loop do
            game_choice = gets
            game_choice = game_choice.chomp.downcase
            if game_choice == "yes" || game_choice == "y"
                puts "Yay!  You chose to play a new game!"
                sleep 2
                game()
            elsif game_choice == "no" || game_choice == "n"
                puts "Thank you for playing Hangman.  Have a great day!"
                exit
            else
                puts "Do you want to play again?  Type yes, no, y or n."
            end
            end
        end
    elsif result == false && !player.correct_letters.include?(letter) && !player.wrong_letters.include?(letter)
        player.false_action(letter, hangman.hangman_tracker, hangman.hangman_display)
        puts hangman.hangman_tracker
    end
    end
    puts "I'm sorry, you did not guess the secret word within 11 guesses.  You lose!"
    puts "m---(v_v)---m"
    sleep 2
    puts "Don't give up!  Do you want to try again?"
    loop do
    game_choice = gets
    game_choice = game_choice.chomp.downcase
    if game_choice == "yes" || game_choice == "y"
        puts "Yay!  You chose to play a new game!"
        sleep 2
        game()
    elsif game_choice == "no" || game_choice == "n"
        puts "Thank you for playing Hangman.  Have a great day!"
        exit
    else
        puts "Do you want to play again?  Type yes, no, y or n."
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
            true
        elsif !secret_word.include?(letter)
            false
        end
    end

    def true_action(letter, secret_word, secret_word_hidden)
        puts "Congratulations!  You chose one of the correct letters!"
        sleep 2
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
            secret_array.join(' ')
        end
        def false_action(letter, tracker, tracker_display)
            puts "I'm sorry, your guess was incorrect."
            sleep 2
            @guesses -= 1
            @wrong_letters.push(letter)
            if @guesses == 10
                tracker.push(tracker_display[0])
            elsif @guesses == 9
                tracker.push(tracker_display[1])
            elsif @guesses == 8
                tracker.push(tracker_display[2])
            elsif @guesses == 7
                tracker.push(tracker_display[3])
            elsif @guesses == 6
                tracker.push(tracker_display[4])
            elsif @guesses == 5
                tracker.push(tracker_display[5])
            elsif @guesses == 4
                tracker.push(tracker_display[6])
            elsif @guesses == 3
                tracker.push(tracker_display[7])
            elsif @guesses == 2
                tracker.push(tracker_display[8])
            elsif @guesses == 1
                tracker.push(tracker_display[9])
            elsif @guesses == 0
                tracker.push(tracker_display[10])
            end

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
    @hangman_tracker = []
    end

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

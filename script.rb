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

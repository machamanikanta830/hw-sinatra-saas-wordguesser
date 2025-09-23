class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  # the below lines are getters
  attr_reader :word, :guesses, :wrong_guesses


  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError if letter.nil? || letter.to_s.strip.empty?

    ch = letter.to_s[0].downcase
    raise ArgumentError unless ch =~ /[a-z]/

    return false if @guesses.include?(ch) || @wrong_guesses.include?(ch)

    if @word.downcase.include?(ch)
      @guesses << ch
    else
      @wrong_guesses << ch
    end
    true
  end

  def word_with_guesses
    @word.chars.map { |c| @guesses.include?(c.downcase) ? c : '-' }.join
  end

  def check_win_or_lose
    return :win  if word_with_guesses == @word
    return :lose if @wrong_guesses.length >= 7
    :play
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end

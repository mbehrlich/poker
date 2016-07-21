# Player
# Each player has a hand, plus a pot
# Player has methods to ask the user:
# Which cards they wish to discard
# Whether they wish to fold, see, or raise.
class Player

  attr_accessor :pot
  attr_reader :hand

  def initialize(pot)
    @pot = pot
  end

  def load_hand
    @hand = Hand.new
  end

  def get_move
    puts "Do you want to fold, see, or raise?"
    answer = gets.chomp
    until valid_move?(answer)
      answer = gets.chomp
    end
    answer
  end

  def valid_move?(answer)
    valids = %w{fold see raise}
    valids.include?(answer)
  end

  def get_bet
    puts "How much would you like to raise"
    answer = gets.chomp.to_i
    until answer <= @pot && answer > 0
      answer = gets.chomp.to_i
    end
    answer
  end

  def discard
    puts "Which cards would you like to discard? (0 to 4)"
    answer = gets.chomp.to_i
    until answer.between?(0,4)
      answer = gets.chomp.to_i
    end
  end

end

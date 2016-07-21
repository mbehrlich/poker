# Hand
# The logic of calculating pair, three-of-a-kind, two-pair, etc. goes here.
# Logic of which hand beats which would go here.
##

##Instance variable to hold 5 card array
##rank function that returns "pair", "two-pair", "flush" etc based on the cards
##rank function probably needs to associate the high card of the ranking...(eg ["pair", 8] or ["flush", "K"])
##compare function to compare rank of self against another?
class Hand

  attr_reader :stack

  RANKINGS = ["high card",
    "pair",
    "two pair",
    "three of a kind",
    "straight",
    "flush",
    "full house",
    "four of a kind",
    "straight flush",
    "royal flush"]

  def initialize
    @stack = []

  end

  def take_cards(card)
    raise "too many cards" if @stack.length == 5
    @stack << card
  end

  def remove_cards(num)
    raise 'wrong arguments' unless num.is_a?(Fixnum) &&
      num.between?(0, 4)
    raise 'not enough cards' if @stack.empty?
    @stack.delete_at(num)
  end

  def rank
    raise "not enough cards" if @stack.length < 5
    if royal_flush?
      RANKINGS[9]
    elsif straight_flush?
      RANKINGS[8]
    elsif four_of_a_kind?
      RANKINGS[7]
    elsif full_house?
      RANKINGS[6]
    elsif flush?
      RANKINGS[5]
    elsif straight?
      RANKINGS[4]
    elsif three_of_a_kind?
      RANKINGS[3]
    elsif two_pair?
      RANKINGS[2]
    elsif pair?
      RANKINGS[1]
    else
      RANKINGS[0]
    end
  end

  def pair?
    values = @stack.map(&:value)
    values.any? {|card| values.count(card) > 1 }
  end

  def three_of_a_kind?
    values = @stack.map(&:value)
    values.any? {|card| values.count(card) > 2 }
  end

  def four_of_a_kind?
    values = @stack.map(&:value)
    values.any? {|card| values.count(card) > 3 }
  end

  def two_pair?
    multiples_hash = Hash.new(0)
    @stack.each do |card|
      multiples_hash[card.value] += 1
    end
    doubles = multiples_hash.values.select do |frequency|
      frequency > 1
    end
    doubles.length == 2
  end

  def full_house?
    multiples_hash = Hash.new(0)
    @stack.each do |card|
      multiples_hash[card.value] += 1
    end
    doubles = multiples_hash.values.select do |frequency|
      frequency > 1
    end
    doubles.include?(3) && doubles.include?(2)
  end

  def straight?
    card_values = @stack.map(&:value).sort
    card_values.last - card_values.first == 4 || card_values == [2, 3, 4, 5, 14]
  end

  def flush?
    @stack.map(&:suit).uniq.length == 1
  end

  def straight_flush?
    straight? && flush?
  end

  def royal_flush?
    straight_flush? && @stack.map(&:value).sort == [10, 11, 12, 13, 14]
  end

  def relative_value
    @stack.map(&:value).sort.reverse
  end

  def self.compare(hand1, hand2)
    rank1 = hand1.rank
    rank2 = hand2.rank
    if rank1 == rank2
      (0..4).each do |index|
        if hand1.relative_value[index] > hand2.relative_value[index]
          return hand1
        elsif hand2.relative_value[index] > hand1.relative_value[index]
          return hand2
        end
      end
      return "push"
    end
    if RANKINGS.index(rank1) > RANKINGS.index(rank2)
      return hand1
    else
      return hand2
    end
  end

end

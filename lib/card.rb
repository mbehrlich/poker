require 'colorize'

class Card

  attr_reader :value, :suit

  def initialize(value, suit)
    raise "error" if !value.between?(2, 14)
    raise "error" unless ["spade", "heart", 'diamond', 'club'].include?(suit)
    @value = value
    @suit = suit
  end

  def to_s
    values = {
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9",
      10 => "10",
      11 => "J",
      12 => "Q",
      13 => "K",
      14 => "A"
    }
    suits = {
      "spade" => "\u2660", #.colorize(:black).colorize(:background => :white),
      "heart" => "\u2665",#.colorize(:red).colorize(:background => :white),
      "diamond" => "\u2666",#.colorize(:red).colorize(:background => :white),
      "club" => "\u2663",#.colorize(:black).colorize(:background => :white),
    }
    suits[@suit].encode('utf-8') + " " + values[@value]


  end

end

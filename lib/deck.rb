class Deck

  attr_reader :stack

  def initialize
    populate
  end

  def populate
    @stack = []
    suits = ["spade", "heart", 'diamond', 'club']
    suits.each do |suit|
      (2..14).each do |num|
        @stack << Card.new(num, suit)
      end
    end
  end

  def deal
    @stack.pop
  end

  def shuffle!
    @stack = @stack.shuffle
  end

end

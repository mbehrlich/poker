require 'deck'

describe Deck do
  subject(:deck) { Deck.new }
  describe '#initialize' do
    it 'contains card objects' do
      card_check = deck.stack.all? do |card|
        card.class == Card
      end
      expect(card_check).to be true
    end
    it 'creates a 52 card stack' do
      expect(deck.stack.length).to eq(52)
    end
    it 'has the right cards' do
      deck.stack.sort_by!(&:value)
      values = deck.stack.map(&:value)
      test_arr = ((2..14).to_a * 4).sort
      expect(values).to eq(test_arr)
    end
  end

  describe '#deal' do
    it 'returns a single card' do
      expect(deck.deal).to be_an_instance_of(Card)
    end

    it 'reduces the stack by one' do
      deck.deal
      expect(deck.stack.length).to eq(51)
    end
  end

  describe '#shuffle!' do
    let(:test_arr) {Deck.new.stack}
      before(:each) do
        deck.shuffle!
      end

      it 'shuffles' do
        expect(deck.stack).to_not eq(test_arr)
      end

      it 'retains the same length' do
        expect(deck.stack.length).to eq(test_arr.length)
      end
  end

end

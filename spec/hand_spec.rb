require 'hand'

describe Hand do
  subject(:hand) { Hand.new }
  let(:card1) { double("card", :value => 3, :suit => "club")}
  let(:card2) { double('card', :value => 10, :suit => 'spade') }
  let(:card3) { double('card', :value => 10, :suit => 'diamond') }
  let(:card4) { double('card', :value => 10, :suit => 'heart') }
  let(:card5) { double('card', :value => 10, :suit => 'club') }

  let(:card6) { double("card", :value => 7, :suit => "club")}
  let(:card7) { double('card', :value => 9, :suit => 'spade') }
  let(:card8) { double('card', :value => 9, :suit => 'diamond') }
  let(:card9) { double('card', :value => 9, :suit => 'heart') }
  let(:card10) { double('card', :value => 9, :suit => 'club') }

  let(:card11) { double("card", :value => 5, :suit => "club")}
  let(:card12) { double('card', :value => 13, :suit => 'spade') }
  let(:card13) { double('card', :value => 13, :suit => 'diamond') }
  let(:card14) { double('card', :value => 4, :suit => 'heart') }
  let(:card15) { double('card', :value => 11, :suit => 'club') }


  describe '#initialize' do
    it 'initalizes with an empty array for stack' do
      expect(hand.stack).to be_an_instance_of(Array)
      expect(hand.stack.length).to eq(0)
    end
  end
  describe '#take_cards' do
    it 'adds a card to your stack' do
      hand.take_cards(card1)
      expect(hand.stack.length).to eq(1)
    end
    it 'won\'t give you more than 5 cards' do
      hand.take_cards(card1)
      hand.take_cards(card1)
      hand.take_cards(card1)
      hand.take_cards(card1)
      hand.take_cards(card1)
      expect { hand.take_cards(card1) }.to raise_error("too many cards")
    end
  end
  describe '#remove_cards' do
    let(:subject) { Hand.new }
    before(:each) do
      hand.take_cards(card1)
    end
    it 'takes a number as an argument' do
      expect { hand.remove_cards }.to raise_error(ArgumentError)
      expect { hand.remove_cards("dog") }.to raise_error("wrong arguments")
      expect { hand.remove_cards(3) }.to_not raise_error
    end
    it 'raises an error if the number doesn\'t match a card object' do
      expect { hand.remove_cards(6) }.to raise_error("wrong arguments")
    end
    it 'removes a card from your stack' do
      hand.remove_cards(0)
      expect(hand.stack.length).to eq(0)
    end
    it 'raises an error if you attempt to remove from an empty stack' do
      hand.remove_cards(0)
      expect { hand.remove_cards(0) }.to raise_error("not enough cards")
    end
  end
  describe '#rank' do
    before(:each) do
      hand.take_cards(card1)
      hand.take_cards(card2)
      hand.take_cards(card3)
      hand.take_cards(card4)
      hand.take_cards(card5)
    end
    it 'raises an error if the stack is < 5 cards long' do
      hand.remove_cards(0)
      expect {hand.rank}.to raise_error("not enough cards")
    end
    it 'returns a rank for a stack of 5' do
      expect(hand.rank).to be_an_instance_of(String)
    end
    it 'has ranks compatible with rules of poker' do
      expect(hand.rank).to eq("four of a kind")
    end
  end
  describe '#relative_value' do
    before(:each) do
      hand.take_cards(card1)
      hand.take_cards(card2)
      hand.take_cards(card3)
      hand.take_cards(card4)
      hand.take_cards(card5)
    end
    it 'returns an array' do
      expect(hand.relative_value).to be_an_instance_of(Array)
    end
    it 'returns values of cards' do
      expect(hand.relative_value).to eq([10, 10, 10, 10, 3])
    end
  end

  describe '::compare' do
    let(:hand2) {Hand.new}
    let(:hand3) {Hand.new}

    before(:each) do
      hand.take_cards(card1)
      hand.take_cards(card2)
      hand.take_cards(card3)
      hand.take_cards(card4)
      hand.take_cards(card5)
      hand2.take_cards(card6)
      hand2.take_cards(card7)
      hand2.take_cards(card8)
      hand2.take_cards(card9)
      hand2.take_cards(card10)
      hand3.take_cards(card11)
      hand3.take_cards(card12)
      hand3.take_cards(card13)
      hand3.take_cards(card14)
      hand3.take_cards(card15)
    end

    it 'takes two hands as arguments' do
      expect { Hand.compare }.to raise_error(ArgumentError)
      expect { Hand.compare(hand, hand2) }.to_not raise_error
    end
    it 'correctly returns the winner' do
      expect(Hand.compare(hand, hand2)).to be(hand)
      expect(Hand.compare(hand2, hand3)).to be(hand2)
    end
    it 'correctly returns "push" if hands are equal' do
      expect(Hand.compare(hand, hand)).to eq("push")
    end
  end
end

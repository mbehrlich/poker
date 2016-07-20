require 'card'


describe Card do
  let(:ace) { Card.new(14, 'spade') }
  let(:three) { Card.new(3, 'heart') }
  describe '#initialize' do
    it 'assigns a correct value' do
      expect(ace.value).to eq(14)
      expect(three.value).to eq(3)
    end
    it 'assigns a correct suit' do
      expect(ace.suit).to eq('spade')
      expect(three.suit).to eq('heart')
    end
    it 'raises an error on strange cards' do
      expect { Card.new(15, 'joker') }.to raise_error('error')
    end
  end
  describe '#to_s' do
    it 'returns a string that gives the suit and value of the card' do
      expect(ace.to_s).to eq("\u2660".encode('utf-8') + " " + 'A')
      expect(three.to_s).to eq("\u2665".encode('utf-8') + " " + '3')
    end
  end
end

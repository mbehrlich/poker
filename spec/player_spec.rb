require 'player'

describe Player do
  subject(:player) { Player.new(100) }
  describe '#initialize' do
    it 'initializes with a pot' do
      expect(player.pot).to eq(100)
    end
  end
  describe '#load_hand' do
    it 'creates a hand' do
      player.load_hand
      expect(player.hand).to be_an_instance_of(Hand)
    end
  end
end

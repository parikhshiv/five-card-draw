require 'rspec'
require 'player'

describe Player do
  subject(:player) { Player.new([], 80)}
  describe "#initialize" do
    it "initializes a hand and a pot" do
      expect(player.hand).to eq([])
      expect(player.pot).to be(80)
    end
  end
end

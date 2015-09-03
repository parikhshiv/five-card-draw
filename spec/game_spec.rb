require 'rspec'
require 'game'

describe Game do
  subject(:game) {Game.new(1,2,3,4,5,6,7)}

  describe "#initialize" do
    it "processes up to four players" do
      expect(game.players).to eq([1,2,3,4])
    end
  end

  describe "#over?" do
    it "returns false if all but one bankrolls aren't empty" do
      expect(game.over?).to eq(false)
    end

    it "returns true when all but one bankrolls are empty " do
      expect(over_game.over?).to eq(true)
    end

  end
end

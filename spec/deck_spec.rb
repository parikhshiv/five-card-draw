require 'rspec'
require 'deck'

describe Deck do
  describe "#initialize" do
    let(:deck) {Deck.new}
    it "builds a deck that has 52 cards" do
      expect(deck.deck_array.length).to eq(52)
    end
    it "builds a deck that has four different suits" do
      expect(deck.deck_array.map {|deck| deck.suit}.uniq.length).to eq(4)
    end
    it "builds a deck that has 13 different values" do
      expect(deck.deck_array.map {|deck| deck.value}.uniq.length).to eq(13)
    end
  end
end

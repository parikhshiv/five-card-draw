require 'rspec'
require 'hand'

describe Hand do
  let(:card1) { double("card1", suit: :spade, value: 14 )}
  let(:card2) { double("card2", suit: :spade, value: 13 )}
  let(:card3) { double("card3", suit: :spade, value: 12 )}
  let(:card4) { double("card4", suit: :spade, value: 11 )}
  let(:card5) { double("card5", suit: :spade, value: 10 )}
  let(:card6) { double("card6", suit: :spade, value: 8 )}
  let(:card7) { double("card7", suit: :diamond, value: 8 )}
  let(:card8) { double("card8", suit: :diamond, value: 9 )}
  let(:card9) { double("card9", suit: :heart, value: 8)}
  let(:card10) { double("card10", suit: :club, value: 8 )}

  let(:hand) {Hand.new([card1, card2, card3, card4, card5])}
  let(:hand2) {Hand.new([card1, card2, card3, card4, card6])}
  let(:hand3) {Hand.new([card7, card8, card3, card4, card5])}
  let(:hand4) {Hand.new([card1, card2, card3, card7, card8])}
  let(:hand5) {Hand.new([card4, card5, card6, card9, card10])}

  describe "#initialize" do
    let(:card1) { double("card1", class: Card)}
    let(:hand) {Hand.new(Array.new(5) { card1 } )}
    let(:bad_hand) {Hand.new(Array.new(4) { card1} )}
    it "creates a hand of five things" do
      expect(hand.current_hand.length).to eq(5)
    end

    it "creates a hand of all cards" do
      expect(hand.current_hand.all? {|thing| thing.class == Card})
    end
  end

  describe "#calculate_hand" do
    it "can calculate a straight_flush" do
        expect(hand.calculate_hand).to eq(:straight_flush)
    end

    it "can calculate a flush" do
      expect(hand2.calculate_hand).to eq(:flush)
    end

    it "can calculate a straight" do
      expect(hand3.calculate_hand).to eq(:straight)
    end
  end

  describe "#compare_hands" do

    it "returns true if own hand is better, general case" do
      expect(hand.compare_hands(hand2)).to eq(true)
    end

    it "returns the better hand in a tie-breaker hand" do
      expect(hand4.compare_hands(hand5)).to eq(true)
    end
  end
end

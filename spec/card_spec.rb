require 'rspec'
require 'card'

describe Card do
  describe "#initialize" do
    subject(:card) { Card.new(:spade, :A)}
    it "initializes a suit and a value" do
      expect(card.suit).to be(:spade)
      expect(card.value).to be(:A)
    end
  end
end

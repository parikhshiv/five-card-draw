require_relative 'card'
class Deck
  attr_reader :deck_array
  VALUES = {2=> :two, 3=> :three, 4=> :four, 5=> :five, 6=> :six, 7=> :seven,
     8=> :eight, 9=> :nine, 10=> :ten, 11=> :J, 12=>:Q, 13=>:K, 14=>:A}

  SUITS = [:spade, :heart, :club, :diamond]
  def initialize
    @deck_array = []
    build_deck
  end

  private

  def build_deck
    (2..14).each do |idx|
      SUITS.each do |suit|
        @deck_array << Card.new(suit, idx)
      end
    end
    deck_array.shuffle!
  end
end

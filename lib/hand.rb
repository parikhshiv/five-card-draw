
class Hand
  HASH = {straight_flush: 9, four_of_kind: 8, full_house: 7, flush: 6,
    straight: 5, three_of_kind: 4, two_pair: 3, one_pair: 2, none: 1}

  attr_reader :current_hand, :tie_breaker
  def initialize(cards)
    @current_hand = cards
    @rank_of_hands = []
    @tie_breaker = 0
  end

  def self.sort_hands(hands)
    hands.sort_by {|x| [-HASH[x.calculate_hand], x.tie_breaker]}
  end

  def calculate_hand
    @tie_breaker = tie_breaker
    return :straight_flush if straight_flush?
    return :four_of_kind if four_of_kind?
    return :full_house if full_house?
    return :flush if flush?
    return :straight if straight?
    return :three_of_kind if three_of_kind?
    return :two_pair if two_pair?
    return :one_pair if one_pair?
    :none
  end

  private
  def straight_flush?
    straight? && flush?
  end

  def high_card
    counter = value_counter
    high_value = counter.keys.max
    @current_hand.select {|cards| card.value == high_value}.first
  end

  def four_of_kind?
    count = value_counter
    count.has_value?(4)
  end

  def full_house?
    count = value_counter
    count.has_value?(2) && count.has_value?(3)
  end

  def flush?
    count = suit_counter
    count.has_value?(5)
  end

  def straight?
    count = value_counter
    values = count.keys
    count.length == 5 && (values.max - values.min == 4) && values.uniq.length == 5
  end

  def three_of_kind?
    count = value_counter
    count.has_value?(3)
  end

  def two_pair?
    count = value_counter
    count.keys.length == 3 && count.has_value?(2)
  end

  def one_pair?
    count = value_counter
    count.keys.length == 4 && count.has_value?(2)
  end

  def value_counter
    value_counter = Hash.new(0)
    @current_hand.each do |card|
      value_counter[card.value] += 1

    end
    value_counter
  end

  def suit_counter
    suit_counter = Hash.new(0)
    @current_hand.each do |card|
      suit_counter[card.suit] += 1
    end
    suit_counter
  end
end

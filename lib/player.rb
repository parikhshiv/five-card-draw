class Player
  attr_reader :name
  attr_accessor :folded, :bankroll, :final_hand, :player_hand

  def discard_cards
    input = prompt_for_discard
    input.reverse.each do |idx|
      @player_hand.delete_at(idx)
    end
  end

  def create_final_hand
    @final_hand = Hand.new(@player_hand)
  end

  def display_player_hand
    @player_hand.map {|card| card.to_s}
  end
  def prompt_for_bet
    puts "#{@name}, Your hand is #{display_player_hand}"
    puts "Do you wish to fold, call, or raise? (F, C, or R)"
    input = gets.chomp.downcase
    if input == 'r'
      puts "How much do you want to raise?"
      return gets.chomp.to_i
    end
    input
  end

  private

  def initialize(name, bankroll)
    @name = name
    @player_hand = []
    @bankroll = bankroll
    @folded = false
  end

  def prompt_for_discard
    puts "#{@name}, Your hand is #{display_player_hand}"
    puts "Which of these cards would you like to discard? (Up to three)"
    input = gets.chomp.split(',').map {|str| str.to_i}
  end

end

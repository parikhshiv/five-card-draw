require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'player'

class Game
  attr_reader :players

  def play
    until @players.count {|pl| pl.bankroll > 0} == 1
      play_round
    end
    puts "Not enough players with cash. Game over."
  end

  private

  def initialize(*players)
    @players = players[0..3]
    @hand_over = false
  end

  def play_round
    @pot = 0
    ante
    deal
    play_betting_round
    return if @hand_over
    play_discard_round
    play_betting_round
    return if @hand_over
    create_final_hands
    give_money_to_(reveal_winner)
    @players.rotate!
  end

  def reveal_winner
    remaining_hands = @players.map {|player| player.final_hand }
    remaining_hands.reject! {|hand| hand.current_hand.empty?}
    winning_hand = Hand::sort_hands(remaining_hands).first
    winner = @players.select {|player| player.final_hand == winning_hand}.first
    puts "#{winner.name} wins this round!"
    sleep(1)
    winner
  end

  def create_final_hands
    @players.each do |player|
      next if player.folded
      player.create_final_hand
    end
  end

  def deal
    @deck = Deck.new
    @hand_over = false
    @players.each do |player|
      player.folded = false
      player.player_hand = []
      5.times { player.player_hand << @deck.deck_array.shift }
    end
  end

  def ante
    players[0..1].each do |player|
      player.bankroll -= 5
      @pot += 5
    end
  end

  def play_discard_round
    @players.each do |player|
      system 'clear'
      next if player.folded
      player.discard_cards
      until player.player_hand.length == 5
        player.player_hand << @deck.deck_array.shift
      end
    end
  end

  def most_players_folded
    remaining_players = players.reject {|player| player.folded}
    return remaining_players.first if remaining_players.length == 1
    nil
  end

  def give_money_to_(winner)
    winner.bankroll += @pot
    @hand_over = true
  end

  def play_betting_round
    bet = 0
    ready = false
    until ready
      @players.each do |player|
        system 'clear'
        # puts "#{player.name}'s turn...'"
        # sleep(1)
        ready = true
        next if player.folded
        puts "The pot is #{@pot}"
        puts "The bet is #{bet}"
        puts "Your bankroll is #{player.bankroll}"
        input = player.prompt_for_bet
        if input == 'f'
          player.folded = true
          return give_money_to_(most_players_folded) if most_players_folded
        elsif input == 'c'
          player.bankroll -= bet
          @pot += bet
        else
          ready = false
          bet += input
          player.bankroll -= bet
          @pot += bet
        end
      end
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  Game.new(Player.new("Shiv", 100), Player.new("Player2", 100)).play
end

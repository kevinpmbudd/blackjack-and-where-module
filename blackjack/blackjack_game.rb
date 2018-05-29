require './deck'
require './human'
require './dealer'

class BlackjackGame
  attr_accessor :human, :dealer, :deck

  def initialize
    @deck = Deck.new
    @human = Human.new
    @dealer = Dealer.new
    @game_on = true
  end

  def start
    deal_two_cards
    humans_turn unless @human.has_blackjack
    dealers_turn
    display_final_results
  end

  def deal_two_cards
    2.times do
      @deck.deal_card_to(@human)
      @deck.deal_card_to(@dealer)
    end

    if @human.won?
      @human.has_blackjack = true
      puts 'Congratulations, You have Blackjack! You Win.'
    end

    if @dealer.calculate_card_values == 21
      @dealer.has_blackjack = true
    end
  end

  def show_hands
    puts '-' * 40
    puts 'Humans\'s hand'
    puts @human.show_hand
    puts '-' * 40
    puts 'Dealer is showing'
    puts @dealer.show_hand
    puts '-' * 40
  end

  def humans_turn
    while @game_on && !@human.stays
      if @human.bust?
        puts 'Human, you have gone bust. You lose.'
        @game_on = false
      else
        prompt_human_for_card
        humans_turn
      end
    end
  end

  def dealers_turn
    puts 'Dealer now has their turn...'
    @deck.deal_card_to(@dealer) until @dealer.stays? || @dealer.bust?
  end

  def prompt_human_for_card
    show_hands
    puts 'Another Card?, press c  or Stay?, press s'
    validate_choice(gets.chomp.downcase)
  end

  def validate_choice(choice)
    case choice
    when 'c'
      @deck.deal_card_to(@human)
    when 's'
      @human.stays = true
      puts "human stays with #{human.calculate_card_values}"
    else
      prompt_human_for_card
    end
  end

  def display_final_results
    puts '-' * 40
    puts "Human : #{@human.calculate_card_values}"
    puts "Dealer: #{@dealer.calculate_card_values}"
    find_winner
    puts '-' * 40
    puts 'Game Over'
  end

  def find_winner
    if @human.calculate_card_values == @dealer.calculate_card_values
      puts 'We have a tie. :)'
    elsif is_human_winner?
        puts 'Human you have won!'
    else
      puts 'Dealer you have won'
    end
  end

  def is_human_winner?
    @human.calculate_card_values <= 21 &&
    @human.calculate_card_values > @dealer.calculate_card_values ||
    (@dealer.bust? && !@human.bust?)
  end
end

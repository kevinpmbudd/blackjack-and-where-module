require './card_value_calculator'

class Player

  include CardValueCalculator

  attr_accessor :cards, :has_blackjack, :stays

  def initialize
    @cards = []
    @has_blackjack = false
    @stays = false
  end

  def show_hand
    @cards
  end

  def bust?
    calculate_card_values > 21
  end
end

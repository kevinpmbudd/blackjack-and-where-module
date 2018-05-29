require './card'

class Deck

  attr_accessor :playable_cards

  SUITS = [:hearts, :diamonds, :spades, :clubs]

  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]
  }

  def initialize
    shuffle
  end

  def deal_card_to(player)
    player.cards << @playable_cards.delete_at(0)
  end

  def shuffle
    @playable_cards = []
    SUITS.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
    @playable_cards.shuffle!
  end
end

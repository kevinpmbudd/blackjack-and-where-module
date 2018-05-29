require 'test/unit'
require './blackjack_game'

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end

  def test_card_suit_is_correct
    assert_equal @card.suit, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end

  def test_card_value_is_correct
    assert_equal @card.value, 10
  end

  def test_card_to_s
    assert_equal @card.to_s, 'ten of hearts'
  end
end

class DeckTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
    @human = Human.new
  end

  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end

  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card_to(@human)
    assert(@deck.playable_cards.include?(card) == false)
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end

  def test_deal_card_to_removes_one_card_from_playable_cards
    @deck.deal_card_to(@human)
    assert_equal @deck.playable_cards.size, 51
  end

  def test_deal_card_to_gives_player_one_card
    @deck.deal_card_to(@human)
    assert_equal @human.cards.size, 1
  end

  def test_deal_card_to_deals_player_card_on_top_of_deck_0th_position
    card = @deck.playable_cards[0]
    @deck.deal_card_to(@human)
    assert_equal @human.cards[0], card
  end
end

class PlayerTest < Test::Unit::TestCase
  def setup
    @player = Player.new
    @deck = Deck.new
  end

  def test_bust_returns_false_if_card_less_than_21
    jack_spades = Card.new(:spades, :jack, 10)
    jack_clubs = Card.new(:clubs, :jack, 10)
    @player.cards << jack_spades << jack_clubs
    assert_equal @player.bust?, false
  end

  def test_bust_returns_true_if_card_greater_than_21
    jack_hearts = Card.new(:hearts, :jack, 10)
    jack_spades = Card.new(:spades, :jack, 10)
    jack_clubs = Card.new(:clubs, :jack, 10)
    @player.cards << jack_hearts << jack_spades << jack_clubs
    assert_equal @player.bust?, true
  end
end

class HumanTest < Test::Unit::TestCase
  def setup
    @human = Human.new
    @deck = Deck.new
  end

  def test_cards_initializes_as_empty
    assert_equal @human.cards.size, 0
  end

  def test_has_blackjack_initializes_as_false
    assert_equal @human.has_blackjack, false
  end

  def test_stays_initializes_as_false
    assert_equal @human.stays, false
  end

  def test_includes_card_value_calculator_method
    assert_equal @human.calculate_card_values, 0
  end

  def test_won_returns_false_when_hand_is_empty
    assert_equal @human.won?, false
  end

  def test_won_returns_true_when_hand_equals_21
    ace = Card.new(:hearts, :ace, 11)
    jack = Card.new(:hearts, :jack, 10)
    @human.cards << ace << jack
    assert_equal @human.won?, true
  end

  def test_show_hand_returns_array_of_cards
    ace = Card.new(:hearts, :ace, 11)
    jack = Card.new(:hearts, :jack, 10)
    @human.cards << ace << jack
    assert_equal @human.cards.class, Array
  end
end

class DealerTest < Test::Unit::TestCase
  def setup
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def test_cards_initializes_as_empty
    assert_equal @dealer.cards.size, 0
  end

  def test_has_blackjack_initializes_as_false
    assert_equal @dealer.has_blackjack, false
  end

  def test_stays_initializes_as_false
    assert_equal @dealer.stays, false
  end

  def test_includes_card_value_calculator_method
    assert_equal @dealer.calculate_card_values, 0
  end

  def test_show_hand_returns_one_card_dealer_is_showing
    jack_spades = Card.new(:spades, :jack, 10)
    six_hearts = Card.new(:hearts, :six, 6)
    @dealer.cards << jack_spades << six_hearts
    showing_card = @dealer.show_hand
    assert_equal showing_card, six_hearts
  end

  def test_stays_is_false_when_cards_worth_under_17
    jack_spades = Card.new(:spades, :jack, 10)
    six_hearts = Card.new(:hearts, :six, 6)
    @dealer.cards << jack_spades << six_hearts
    assert_equal @dealer.stays?, false
  end

  def test_stays_is_true_when_cards_worth_over_17
    jack_spades = Card.new(:spades, :jack, 10)
    jack_clubs = Card.new(:clubs, :jack, 10)
    @dealer.cards << jack_spades << jack_clubs
    assert_equal @dealer.stays?, true
  end
end

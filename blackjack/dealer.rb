require './player'

class Dealer < Player

  def show_hand
    @cards[1]
  end

  def stays?
    calculate_card_values >= 17
  end
end

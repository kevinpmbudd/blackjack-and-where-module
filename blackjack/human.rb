require './player'

class Human < Player

  def won?
    calculate_card_values == 21
  end
end

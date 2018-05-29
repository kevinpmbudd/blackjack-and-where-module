module CardValueCalculator

 def calculate_card_values
    aces = 0
    @cards.each { |card| aces += 1 if card.name == :ace }
    return @cards.sum(&:value) if aces == 0

    sum = 0
    @cards.each do |card|
      if card.name == :ace
        sum += 11
      else
        sum += card.value
      end
    end

    while sum > 21 && aces > 0
      sum -= 10
      aces -= 1
    end
    sum
  end
end

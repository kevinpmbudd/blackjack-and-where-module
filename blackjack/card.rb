class Card

  attr_accessor :suit, :name, :value

  def initialize(suit, name, value)
    @suit = suit
    @name = name
    @value = value
  end

  def to_s
    "#{name} of #{suit}"
  end
end

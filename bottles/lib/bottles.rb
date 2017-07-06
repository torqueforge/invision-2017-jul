class Integer
  def to_bottle_number
    BottleNumber.for(self)
  end
end

def BottleNumber(number)
  return number if number.kind_of?(BottleNumber)
  BottleNumber.for(number)
end

#############################
class Bottles
  def song
    verses(99, 0)
  end

  def verses(upper, lower)
      upper.downto(lower).map {|i| verse(i)}.join("\n")
  end

  def verse(number)
    bn  = BottleNumber.for(number)

    "#{bn} of beer on the wall, ".capitalize +
    "#{bn} of beer.\n" +
    "#{bn.action}, " +
    "#{bn.successor} of beer on the wall.\n"
  end
end


#############################
class BottleNumber
  def self.for(number)
    registry = [BottleNumber0, BottleNumber1, BottleNumber]
    registry.find {|candidate| candidate.handles?(number)}.new(number)
  end

  def self.handles?(number)
    true
  end

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def container
    "bottles"
  end

  def pronoun
    "one"
  end

  def quantity
    number.to_s
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def successor
    (number - 1).to_bottle_number
  end
end


class BottleNumber0 < BottleNumber
  def self.handles?(number)
    number == 0
  end

  def quantity
    "no more"
  end

  def action
    "Go to the store and buy some more"
  end

  def successor
    99.to_bottle_number
  end
end

class BottleNumber1 < BottleNumber
  def self.handles?(number)
    number == 1
  end

  def container
    "bottle"
  end

  def pronoun
    "it"
  end
end

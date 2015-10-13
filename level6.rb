class Player
  def initialize()
    @health = 0
    @captives_saved = 0
  end
  
  def play_turn(warrior)
    @direction = (@captives_saved == 0) ? :backward : :forward
    # If there's nothing in the next square
    if (warrior.feel(@direction).empty?)
      if (should_rest? warrior)
        warrior.rest!
      elsif (should_flee? warrior)
        warrior.walk!(:backward)
      else
        warrior.walk!(@direction)
      end
    # If there's something in the next square
    else
      if warrior.feel(@direction).captive?
        warrior.rescue!(@direction)
        @captives_saved += 1
      else
        warrior.attack!(@direction)
      end
    end
    @health = warrior.health
  end
  
  def should_flee?(warrior)
    flee_health = 7
    poor_health = warrior.health < flee_health
    under_attack = under_attack? warrior
    return under_attack && poor_health
  end
  
  def should_rest?(warrior)
    min_health = 15
    good_health = warrior.health > min_health
    under_attack = under_attack? warrior
    return !(good_health || under_attack)
  end

  def under_attack?(warrior)
    return warrior.health < @health
  end

end
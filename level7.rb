class Player
  def initialize()
    @health = 0
    @direction = :forward
  end
  
  def play_turn(warrior)
    if warrior.feel.wall? 
      warrior.pivot!
    elsif (warrior.feel(@direction).empty?)
      if (should_rest? warrior)
        warrior.rest!
      elsif (should_flee? warrior)
        warrior.walk!(:backward)
      else
        warrior.walk!(@direction)
      end
    else
      warrior.attack!(@direction)
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
    min_health = 10
    good_health = warrior.health > min_health
    under_attack = under_attack? warrior
    return !(good_health || under_attack)
  end
  
  def under_attack?(warrior)
    return warrior.health < @health
  end
end
class Player

  def play_turn(warrior)
    if look_ahead(warrior) == "captive"
      if (warrior.feel.captive?)
        warrior.rescue!
      else
        warrior.walk!
      end
    elsif look_ahead(warrior) == "enemy"
      warrior.shoot!
    else
      warrior.walk!
    end
  end
  
  def look_ahead(warrior)
    if (warrior.look.any? { |square| square.captive?})
      return "captive"
    elsif  (warrior.look.any? { |square| square.enemy?})
      return "enemy"
    end
  end

end
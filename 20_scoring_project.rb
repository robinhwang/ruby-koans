def score(dice)
  count = dice.count
  if dice == 1
    return 100 if dice.include?(1)
    return 50 if dice.include?(5)
  end
end
#this complex one is mine, and it's too dirty
#not cool =.=
def score(dice)
  count  = dice.count
  count1 =dice.uniq.count
  situation = count - count1
  score = 0

  if situation == 0 || 1
    score = number(dice, 1) * 100 + number(dice, 5) * 50
  elsif situation == 2
    if find_number == 1
      score = 1000 + number(dice, 5) * 50
    elsif find_number == 5
      score = 500 + number(dice, 1) * 100
    else
      score = number(dice, 1) * 100 + number(dice, 5) * 50 + find_number * 100
    end
  else situation >= 4

  end


   def number(dice,n)
    dice.count(n)
  end

  def find_number
  (1..6).each do {|n|
    return n if number(dice, n) == 3
  }
  end
end


#the better one
SINGLE_ROLL_MUTIPLIERS = [0, 100, 0, 0, 0, 50, 0]
def score(dice)
  score = 0
  (1..6).each do |number|
    roll_count = dice.count{|dice| dice == number }
    if roll_count >= 3
      score += number == 1 ? 1000 : 100 * number
      roll_count -= 3
    end
    score += roll_count * SINGLE_ROLL_MUTIPLIERS[number]
  end
  score
end






def triangle(a, b, c)
  sides = [a, b, c].sort
  if sides.any? {|side| side == 0 }
    raise TriangleError, "side can not be zero"
  end
  if sides.any? {|side| side < 0}
    raise TriangleError, "length of side should not be negative"
  end
  if (sides[0] + sides[1]) < sides[2]
    raise TriangleError, "one side is too long"
  end
  if (sides[0] + sides[1] == sides[2])
    raise TriangleError, "one_side_same_length_as_other_two"
  end
  sides.uniq!
  if sides.count == 1
    :equilateral
  elsif sides.count == 2
    :isosceles
  else
    :scalene
  end
end

class TriangleError < StandardError
end
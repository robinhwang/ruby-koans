##good coding style

def triangle(a, b, c)
  sides = [a, b, c].sort
  raise TriangleError if sides.any? { |side|
    side <= 0
  }
  raise TriangleError unless (sides[0] + sides[1]) > sides[2]
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

class AboutTriangleProject < EdgeCase::Koan
  def test_equilateral_triangles_have_equal_sides
    assert_equal :equilateral, triangle(2, 2, 2)
    assert_equal :equilateral, triangle(7, 7, 7)
  end

  def test_isosceles_triangles_have_exactly_two_sides_equal
    assert_equal :isosceles, triangle(3, 4, 4)
    assert_equal :isosceles, triangle(5, 5, 3)
  end

  def test_scalene_triangles_have_no_equal_sides
    assert_equal :scalene, triangle(3, 4, 5)
  end
end

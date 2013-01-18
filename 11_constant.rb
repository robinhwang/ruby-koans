###1
C = "top level"
class A
  C = "nested"
end

def test_nested_constants_may_also_be_referenced_with_relative_peths
  assert_equal "nested", C
  #it's what seen in irb, may v1.8's rule not working in v1.9
end

def test_top_level_constants_are_referenced_by_double_colons
  assert_equal "top level", ::C
end

def test_nested_constants_are_referenced_by_their_complete_path
  assert_equal "nested", A::C
  assert_equal "nested", ::A::C
end

###2
class Animal
  LEGS = 4
  def leg_in_animal
    LEGs
  end

  class NestedAnimal
    def leg_in_nested_animal
      LEGs
    end
  end
end

def test_nested_classes_inherit_constants_from_enclosing_classes
  assert_equal 4, Animal::NestedAnimal.new.leg_in_nested_animal
end

###3
class Reptile < Animal
  def legs_in_reptile
    LEGS
  end
end

def test_subclasses_inherit_constants_from_parent_classes
  assert_equal 4, Reptile.new.legs_in_reptile
end

###4
class MyAnimals
  LEGS = 2

  class Bird < Animal
    def leg_in_bird
      LEGS
    end
  end
end

def test_who_wins_with_both_nested_and_inherited_constants
  assert_equal 2, MyAnimals::Bird.new.leg_in_bird
end

###5
class MyAnimall::Oyster < Animal
  def leg_in_oyster
    LEGS
  end
end

def test_who_wins_with_explicit_scoping_on_class_definiton
  assert_equal 4, MyAnimals::Oyster.new.leg_in_oyster
end


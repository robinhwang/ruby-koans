###1
def my_global_method(a,b)
  a + b
end

class AboutMethods < EdgeCase::Koan
  def test_calling_global_methods
    assert_equal 5, my_global_method(2,3)
  end

  def test_calling_global_methods_without_parentheses
    result = my_global_method 2, 3
    assert_equal 5, result
  end

  def test_sometimes_missing_parentheses_are_ambiguous
    eval "assert_equal 5, my_global_method(2, 3)"
  end

  def test_calling_global_methods_with_wrong_number_of_arguments
    expression = assert_raise(ArgumentError) do
      my_global_method
    end
    assert_match(/0 for 2/), exception.message

    exception = assert_raise(ArgumentError) do
      my_global_method(1,2,3)
    end
    assert_match(/3 for 2/), exception.message
  end
end

###2

def method_with_default(a, b=:default_value)
  [a, b]
end

def test_calling_with_default_values
  assert_equal [1, :default_value], method_with_default(1)
  assert_equal [1, 2], method_with_default(1, 2)
end

###3
def method_wth_var_args(*args)
  args
end

def test_calling_with_variable_arguments
  assert_equal [], method_wth_var_args
  assert_equal [:one], method_wth_var_args(:one)
  assert_equal [:one, :two], method_wth_var_args(:one, :two)
end

###4
def method_with_explicit_return
  :a_non_return_value
  return :return_value
  :another_non_return_value
end

def test_method_with_explicit_return
  assert_equal :return_value, method_with_explicit_return
end

###5

def method_without_explicit_return
  :a_non_return_value
  :return_value
end

def test_method_without_explicit_return
  assert_equal :return_value, method_without_explicit_return
end

###6
def my_same_class_method(a,b)
  a * b
end

def test_calling_methods_in_same_class
  assert_equal 12, my_same_class_method(3,4)
end

def test_calling_methods_in_same_class_with_explicit_receiver
  assert_equal 12, self.my_same_class_method(3, 4)
end

###7

def my_private_method
  "a secret"
end
private :my_private_method


def test_calling_private_methods_without_receiver
  assert_equal "a secret", my_private_method
end

def test_calling_private_methods_with_an_explicit_receiver
  exception = assert_raise(NoMethodError) do
    self.my_private_method
  end
  assert_match(/private_method/), exception.message
end

###8

class Dog
  def name
    "Fido"
  end

  def tail
    "tail"
  end
end

def test_calling_methods_in_other_objects_require_explicit_recceiver
  rover = Dog.new
  assert_equal "Fido", rover.name
end

def test_calling_private_methods_in_other_objects
  rover = Dog.new
  assert_raise(NoMethodError) do
    rover.tail
  end
end
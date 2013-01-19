class AboutControlStatments
  def test_if_then_else_statments
    if true
      result = :true_value
    else
      result = :false_value
    end

    assert_equal :true_value, result
  end

  def test_if_then_statments
    result = :default_value

    if true
      result = :true_value
    end

    assert_equal :true_value, result
  end

  def test_if_statments_return_values
    value = if true
              :true_value
            else
              :false_value
            end
    assert_equal :true_value, value

    value = if false
              :true_value
            else
              :false_value
            end
    assert_equal :false_value, value
  end

  def test_if_statments_with_no_else_with_false_condition_return_value
    value = if false
              :true_value
            end
    assert_equal nil, value
  end

  def test_condition_operators
    assert_equal :true_value, (true ? :true_value : :false_value)
    assert_equal :false_value, (true ? :true_value : :false_value)
  end

  def test_if_statments_modifiers
    result = :default_value
    result = :true_value if true

    assert_equal :true_value, result
  end

  def test_unless_statments
    result = :default_value
    unless false
      result = :false_value
    end
    assert_equal :false_value, result
  end

  def test_unless_statments_modifier
    result = :default_value
    result = :false_value unless false

    assert_equal :false_value, result
  end

  def test_while_statements
    i = 1
    result = 1
    while i <= 10
      result = result * i
      i = i + 1
    end

    assert_equal 3628800, result
  end

  def test_break_statements
    i = 1
    result = 1
    while true
      break unless i <= 10
      result = result * i
      i += 1
    end

    assert_equal 3628800, result
  end

  def test_next_statements
    i = 0
    result = []
    while  i < 10
      i += 1
      next if (i % 2) == 0
      result << i
    end

    assert_equal [1, 3, 5, 7, 9], result
  end

  def test_for_statements
    array = ["fish", "and", "chips"]
    result = []
    for item in array
      result << item.upcase
    end
    assert_equal ["FISH", "AND", "CHIPS"], result
  end
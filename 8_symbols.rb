class AboutSymbols < EdgeCase::Koan
  def test_symbols_are_symbols
    symbol = :ruby
    assert_equal true, symbol.is_a?(Symbol)
  end

  def test_symbol_can_be_compared
    symbol11 = :a_symbol
    symbol12 = :b_symbol
    symbol13 = :something_else

    assert_equal true, symbol11 == symbol12
    assert_equal false, symbol11 == symbol13
  end

  def test_identical_symbols_are_a_single_internel_object
    symbol11 = :a_symbol
    symbol12 = :a_symbol

    assert_equal true, symbol11 == symbol12
    assert_equal true, symbol11.object_id = symbol12.object_id
  end

  def test_method_names_become_symbols
    symbol_as_strings = Symbol.all_symbols.map{ |x| x.to_s}
    assert_equal false, symbol_as_strings.include?("test_method_names_become_symbols")
  #truly false in v1.9.3
  #but after all I think method name are symbols such as above
    assert_equal true, symbol_as_strings.include?("each")
  end

  def test_symbols_can_be_made_from_strings
    string = "catAndDogs"
    assert_equal :catAndDogs, string.to_sym
  end

  def test_symbols_with_spaces_can_be_built
    symbol = :"cats and dogs"

    assert_equal symbol, "cats and dogs".to_sym
  end

  def test_symbols_with_interpolation_can_be_built
    value = "and"
    symbol = :"cats #{value} dogs"

    assert_equal symbol, "cats and dogs".to_sym
  end

  def test_to_s_is_called_on_interpolated_symbols
    symbol = :cats
    string = "It is raining #{symbol} and dogs."

    assert_equal "It is raining cats and dogs", string
  end

  def test_symbol_are_not_strings
    symbol = :ruby
    assert_equal false, symbol.is_a?(String)
    assert_equal false, symbol.eql?("ruby")
  end

  def test_symbols_do_not_have_string_methods
    symbol = :not_a_string
    assert_equal false, symbol.respond_to?(:each_other)
    assert_equal false, symbol.respond_to?(:reverse)
  end

  def test_symbols_cannot_be_concatenated
    assert_raise(NoMethodError) do
      :cats + :dogs
    end
  end

  def test_symbols_can_be_dynamically_created
    assert_equal :catsdogs, ("cats" + "dogs").to_sym
  end
end

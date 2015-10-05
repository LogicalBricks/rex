require 'test_helper'

class AttributeTest < Minitest::Test
  def test_it_receives_an_original_attrbute_name
    rex_attribute = Rex::Attribute.new(:name)
    assert_equal :name, rex_attribute.original

    rex_attribute = Rex::Attribute.new(:amount)
    assert_equal :amount, rex_attribute.original
  end

  def test_it_uses_the_original_attribute_name_as_target_when_no_target_is_specified
    rex_attribute = Rex::Attribute.new(:name)
    assert_equal :name, rex_attribute.target

    rex_attribute = Rex::Attribute.new(:amount)
    assert_equal :amount, rex_attribute.target
  end

  def test_it_uses_the_target_attribute_name_when_it_is_specified
    rex_attribute = Rex::Attribute.new(:name, target: :full_name)
    assert_equal :full_name, rex_attribute.target

    rex_attribute = Rex::Attribute.new(:amount, target: :total)
    assert_equal :total, rex_attribute.target
  end

  def test_original_is_true_when_the_original_attribute_name_matches_with_the_parameter
    rex_attribute = Rex::Attribute.new(:name)
    assert rex_attribute.original?(:name)
  end

  def test_original_is_false_when_the_original_attribute_name_does_not_match_with_the_parameter
    rex_attribute = Rex::Attribute.new(:name)
    refute rex_attribute.original?(:full_name)
  end

  def test_target_is_true_when_the_target_attribute_name_matches_with_the_parameter
    rex_attribute = Rex::Attribute.new(:name, target: :full_name)
    assert rex_attribute.target?(:full_name)
  end

  def test_target_is_false_when_the_target_attribute_name_does_not_match_with_the_parameter
    rex_attribute = Rex::Attribute.new(:name, target: :full_name)
    refute rex_attribute.target?(:other)
  end

  def test_with_nested_attributes_returns_false_if_nested_attributes_is_not_set
    rex_attribute = Rex::Attribute.new(:name)
    refute rex_attribute.with_nested_attributes?
  end

  def test_with_nested_attributes_returns_false_if_nested_attributes_is_empty
    rex_attribute = Rex::Attribute.new(:name, nested: [])
    refute rex_attribute.with_nested_attributes?
  end

  def test_with_nested_attributes_returns_true_if_nested_attributes_is_not_empty
    rex_attribute = Rex::Attribute.new(:name, nested: [Rex::Attribute.new(:first_name), Rex::Attribute.new(:last_name)])
    assert rex_attribute.with_nested_attributes?
  end

  def test_nested_returns_the_list_of_nested_attributes
    nested_attributes = [Rex::Attribute.new(:first_name), Rex::Attribute.new(:last_name)]
    rex_attribute = Rex::Attribute.new(:name, nested: nested_attributes)
    assert_equal nested_attributes, rex_attribute.nested
  end

  def test_include_original_is_true_when_nested_attributes_include_the_attribute
    rex_attribute = Rex::Attribute.new(:name, nested: [
      Rex::Attribute.new(:first_name),
      Rex::Attribute.new(:initial),
      Rex::Attribute.new(:last_name),
    ])
    assert rex_attribute.include_original?(:first_name)
  end

  def test_include_original_is_false_when_nested_attributes_do_not_include_the_attribute
    rex_attribute = Rex::Attribute.new(:name, nested: [
      Rex::Attribute.new(:first_name),
      Rex::Attribute.new(:initial),
      Rex::Attribute.new(:last_name),
    ])
    refute rex_attribute.include_original?(:other)
  end

  def test_include_target_is_true_when_nested_attributes_include_the_attribute
    rex_attribute = Rex::Attribute.new(:name, nested: [
      Rex::Attribute.new(:first_name),
      Rex::Attribute.new(:initial, target: :middle),
      Rex::Attribute.new(:last_name),
    ])
    assert rex_attribute.include_target?(:middle)
  end

  def test_include_target_is_false_when_nested_attributes_do_not_include_the_attribute
    rex_attribute = Rex::Attribute.new(:name, nested: [
      Rex::Attribute.new(:first_name),
      Rex::Attribute.new(:initial),
      Rex::Attribute.new(:last_name),
    ])
    refute rex_attribute.include_target?(:other)
  end

  def test_nested_for_returns_the_nested_attribute_that_matches_with_the_original
    first_name = Rex::Attribute.new(:first_name)
    initial = Rex::Attribute.new(:initial)
    last_name = Rex::Attribute.new(:last_name)
    rex_attribute = Rex::Attribute.new(:name, nested: [
      first_name,
      initial,
      last_name,
    ])
    assert_equal initial, rex_attribute.nested_for(original: :initial)
    assert_equal last_name, rex_attribute.nested_for(original: :last_name)
  end

  def test_nested_for_returns_the_nested_attribute_that_matches_with_the_target
    first_name = Rex::Attribute.new(:first_name)
    initial = Rex::Attribute.new(:initial, target: :middle_name)
    last_name = Rex::Attribute.new(:last_name)
    rex_attribute = Rex::Attribute.new(:name, nested: [
      first_name,
      initial,
      last_name,
    ])
    assert_equal initial, rex_attribute.nested_for(target: :middle_name)
    assert_equal last_name, rex_attribute.nested_for(target: :last_name)
    assert_equal first_name, rex_attribute.nested_for(original: :first_name)
  end

  def test_nested_for_returns_nil_if_none_matches
    first_name = Rex::Attribute.new(:first_name)
    initial = Rex::Attribute.new(:initial, target: :middle_name)
    last_name = Rex::Attribute.new(:last_name)
    rex_attribute = Rex::Attribute.new(:name, nested: [
      first_name,
      initial,
      last_name,
    ])
    assert_equal nil, rex_attribute.nested_for(target: :other)
    assert_equal nil, rex_attribute.nested_for(original: :other)
  end
end

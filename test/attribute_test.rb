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
end

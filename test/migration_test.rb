require 'test_helper'

class MigrationTest < Minitest::Test
  def test_it_generates_a_hash_with_one_attribute
    hash = { name: 'Homer Simpson' }
    expected_hash = { name: 'Homer Simpson' }
    config = Rex::Attribute.new(:base, nested: [ Rex::Attribute.new(:name)])
    assert_equal(expected_hash, Rex::Migration.new.migrate(hash, config: config))
  end

  def test_it_generates_a_hash_with_two_attributes
    hash = { first_name: 'Homer', last_name: 'Simpson' }
    expected_hash = { first_name: 'Homer', last_name: 'Simpson' }
    config = Rex::Attribute.new(:config, nested: [ Rex::Attribute.new(:first_name), Rex::Attribute.new(:last_name)])
    assert_equal(expected_hash, Rex::Migration.new.migrate(hash, config: config))
  end

  def test_it_generates_a_hash_without_filtered_attributes
    hash = { first_name: 'Homer', last_name: 'Simpson' }
    expected_hash = { first_name: 'Homer' }
    config = Rex::Attribute.new(:config, nested: [ Rex::Attribute.new(:first_name)])
    assert_equal(expected_hash, Rex::Migration.new.migrate(hash, config: config))
  end
end

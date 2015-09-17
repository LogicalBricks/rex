require 'test_helper'

class RexTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Rex::VERSION
  end
end

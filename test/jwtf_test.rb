require "test_helper"

class JWTFTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::JWTF::VERSION
  end
end

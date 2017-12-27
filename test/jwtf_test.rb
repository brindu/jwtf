require "test_helper"

class JWTFTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::JWTF::VERSION
  end

  def test_injects_configuration_into_encoder
    config = JWTF.send(:config)
    encoder = JWTF.send(:encoder)

    assert_same config, encoder.config
  end

  def test_generate_delegates_token_generation_to_encoder
    # https://github.com/seattlerb/minitest/blob/master/lib/minitest/mock.rb#L194
    # Link to the doc for the test understanding
    mock = Minitest::Mock.new
    mock.expect(:call, nil)
    encoder = JWTF.send(:encoder)
    encoder.stub(:call, mock) { JWTF.generate }
    mock.verify
  end

  def test_generate_returns_a_jwt
    token = JWTF.generate
    jwt_regex = /\A([a-zA-Z0-9_-]+\.){2}([a-zA-Z0-9_-]+)?\z/

    assert_match jwt_regex, token
  end
end

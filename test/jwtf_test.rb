require "test_helper"

class JWTFTest < Minitest::Test

  # Reset config after each tests
  def teardown
    if JWTF.instance_variable_defined?(:@config)
      JWTF.instance_variable_set(:@config, nil)
    end
  end

  def test_that_it_has_a_version_number
    refute_nil ::JWTF::VERSION
  end

  def test_generate_returns_a_jwt
    token = JWTF.generate
    jwt_regex = /\A([a-zA-Z0-9_-]+\.){2}([a-zA-Z0-9_-]+)?\z/

    assert_match jwt_regex, token
  end

  def test_generate_encodes_empty_hash_as_default_payload
    token = JWTF.generate
    decoded_token = JWT.decode(token, nil, false)

    assert_instance_of Hash, decoded_token[0]
    assert_empty decoded_token[0]
  end

  def test_generate_encodes_payload_when_configured
    JWTF.configure do |config|
      config.payload = { much: 'payload' }
    end

    token = JWTF.generate
    decoded_token = JWT.decode(token, nil, false)

    assert_equal decoded_token[0]['much'], 'payload'
  end

  def test_generate_signed_token
    JWTF.configure do |config|
      config.payload = { so: 'secret' }
      config.algorithm = 'HS256'
      config.secret = 'much secret'
    end

    token = JWTF.generate
    algo = { algorithm: 'HS256' }
    decoded_token = JWT.decode(token, 'much secret', true, algo)

    assert_equal decoded_token[0]['so'], 'secret'
  end
end

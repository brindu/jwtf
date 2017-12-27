require 'test_helper'

class JWTF::ConfigurationTest < Minitest::Test
  def setup
    @config = JWTF::Configuration.new
  end

  def test_default_token_payload_is_empty_hash
    default_payload = @config.payload

    assert_instance_of Hash, default_payload
    assert_empty default_payload
  end

  def test_set_token_payload
    payload = { test: 'much payload' }
    @config.payload = payload

    assert_equal payload, @config.payload
  end

  def test_default_algorithm_is_none
    assert_equal @config.algorithm, 'none'
  end

  def test_set_algorithm
    @config.algorithm = 'HS256'

    assert_equal @config.algorithm, 'HS256'
  end

  def test_set_secret
    @config.secret = 'much algo'

    assert_equal @config.secret, 'much algo'
  end
end

require 'test_helper'

class JWTF::ConfigurationTest < Minitest::Test
  def test_default_token_payload_is_empty_hash
    default_payload = JWTF::Configuration.new.payload

    assert_instance_of Hash, default_payload
    assert_empty default_payload
  end

  def test_set_token_payload
    config = JWTF::Configuration.new
    payload = { test: 'much payload' }
    config.payload = payload

    assert_equal payload, config.payload
  end
end

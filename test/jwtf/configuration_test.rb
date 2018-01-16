require 'test_helper'

class JWTF::ConfigurationTest < Minitest::Test
  def setup
    @config = JWTF::Configuration.new
  end

  def test_default_token_payload_is_a_proc_and_returning_empty_hash
    default_payload_block = @config.payload

    assert_instance_of Proc, default_payload_block
    assert_instance_of Hash, default_payload_block.call
    assert_empty default_payload_block.call
  end

  def test_set_token_payload_block
    p = Proc.new { { coucou: 'payload' } }
    @config.token_payload(&p)

    assert_equal p, @config.payload
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

  def test_iat_claim_is_disabled_by_default
    assert_equal @config.use_iat_claim, false
  end

  def test_set_iat_claim_use
    @config.use_iat_claim = true

    assert_equal @config.use_iat_claim, true
  end
end

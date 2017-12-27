require 'test_helper'

class JWTF::EncodeTest < Minitest::Test
  def setup
    @config = JWTF::Configuration.new
  end

  def test_encodes_empty_hash_as_default_payload
    encoder = JWTF::Encode.new(@config)
    token = encoder.call
    decoded_token = JWT.decode(token, nil, false)

    assert_instance_of Hash, decoded_token[0]
    assert_empty decoded_token[0]
  end

  def test_encodes_payload_when_configured
    @config.payload = { much: 'payload' }
    encoder = JWTF::Encode.new(@config)
    token = encoder.call
    decoded_token = JWT.decode(token, nil, false)

    assert_equal decoded_token[0]['much'], 'payload'
  end

  def test_encodes_signed_token
    @config.payload = { so: 'secret' }
    @config.algorithm = 'HS256'
    @config.secret = 'much secret'
    encoder = JWTF::Encode.new(@config)
    token = encoder.call
    algo = { algorithm: 'HS256' }
    decoded_token = JWT.decode(token, 'much secret', true, algo)

    assert_equal decoded_token[0]['so'], 'secret'
  end
end

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

  def test_encodes_payload_dynamically
    @config.token_payload do |params|
      dynamic_value = params[:value]
      { so_dynamic: dynamic_value }
    end

    encoder = JWTF::Encode.new(@config)
    token = encoder.call({ value: 'wow' })
    decoded_token = JWT.decode(token, nil, false)

    assert_equal decoded_token[0]['so_dynamic'], 'wow'
  end

  def test_encodes_signed_token
    @config.tap do |c|
      c.token_payload { { so: 'secret' } }
      c.algorithm = 'HS256'
      c.secret = 'much secret'
    end
    encoder = JWTF::Encode.new(@config)
    token = encoder.call
    algo = { algorithm: 'HS256' }
    decoded_token = JWT.decode(token, 'much secret', true, algo)

    assert_equal decoded_token[0]['so'], 'secret'
  end
end

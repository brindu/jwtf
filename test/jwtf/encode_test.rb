require 'test_helper'

class JWTF::EncodeTest < Minitest::Test
  include JWTF::Test::TokenDecode

  def setup
    @config = JWTF::Configuration.new
    @encoder = JWTF::Encode.new(@config)
  end

  def test_encodes_empty_hash_as_default_payload
    token = @encoder.call
    decoded_payload = jwt_payload(token)

    assert_instance_of Hash, decoded_payload
    assert_empty decoded_payload
  end

  def test_encodes_payload_dynamically
    @config.token_payload do |params|
      dynamic_value = params[:value]
      { so_dynamic: dynamic_value }
    end
    token = @encoder.call({ value: 'wow' })
    decoded_payload = jwt_payload(token)

    assert_equal decoded_payload[:so_dynamic], 'wow'
  end

  def test_encodes_signed_token
    @config.tap do |c|
      c.token_payload { { so: 'secret' } }
      c.algorithm = 'HS256'
      c.secret = 'much secret'
    end
    token = @encoder.call
    algo = { algorithm: 'HS256' }
    decoded_token = JWT.decode(token, 'much secret', true, algo)

    assert_equal decoded_token[0]['so'], 'secret'
  end

  def test_set_iat_claim_into_payload
    @config.use_iat_claim = true
    token = @encoder.call
    decoded_payload = jwt_payload(token)

    refute_nil decoded_payload[:iat]
    assert_instance_of Integer, decoded_payload[:iat]
  end

  def test_set_exp_claim_into_payload
    @config.exp_period = { months: 2 }
    token_creation_date = Time.now.to_i
    token = JWTF::Encode.new(@config).call
    decoded_payload = jwt_payload(token)
    expiration_date = decoded_payload[:exp]

    refute_nil expiration_date
    # 30 days month equals 2_592_000 seconds
    # giving 2 seconds lag to the encoder for expiration time approximation
    assert_operator expiration_date, :<=, token_creation_date + 5_184_000 + 2
    assert_operator token_creation_date + 5_184_000, :<=, expiration_date
  end
end

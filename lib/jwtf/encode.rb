require 'jwt'

module JWTF
  class Encode
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def call(params = {})
      payload = config.payload.call(params)

      set_iat_claim(payload) if use_iat_claim
      ::JWT.encode(payload, secret, algorithm)
    end

    private

    extend Forwardable

    def_delegators :@config, :algorithm, :secret, :use_iat_claim

    def set_iat_claim(payload)
      payload[:iat] = Time.now.to_i
    end
  end
end

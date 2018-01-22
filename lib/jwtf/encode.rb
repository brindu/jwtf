require 'jwt'
require 'jwtf/period'

module JWTF
  class Encode
    attr_reader :config

    def initialize(config)
      @config = config

      if @config.exp_period
        @exp_period = JWTF::Period.new(config.exp_period)
      end
    end

    def call(params = {})
      payload = config.payload.call(params)

      add_iat_claim(payload) if use_iat_claim
      add_exp_claim(payload) if expiration_date?
      ::JWT.encode(payload, secret, algorithm)
    end

    private

    extend Forwardable

    def_delegators :@config, :algorithm, :secret, :use_iat_claim

    def add_iat_claim(payload)
      payload[:iat] = Time.now.to_i
    end

    def expiration_date?
      @exp_period
    end

    def add_exp_claim(payload)
      exp_in_seconds = @exp_period.in_seconds
      payload['exp'] = Time.now.to_i + exp_in_seconds
    end
  end
end

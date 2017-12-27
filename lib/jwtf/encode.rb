require 'jwt'

module JWTF
  class Encode
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def call
      payload = config.payload
      algo = config.algorithm
      secret = config.secret
      ::JWT.encode(payload, secret, algo)
    end
  end
end

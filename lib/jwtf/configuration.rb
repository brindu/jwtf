module JWTF
  class Configuration
    attr_accessor :algorithm, :secret, :use_iat_claim
    attr_reader :payload

    def initialize
      @payload = Proc.new { {} }
      @algorithm = 'none'
      @use_iat_claim = false
    end

    def token_payload(&block)
      @payload = block
    end
  end
end

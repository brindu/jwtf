module JWTF
  class Configuration
    attr_accessor :algorithm, :secret
    attr_reader :payload

    def initialize
      @payload = Proc.new { {} }
      @algorithm = 'none'
    end

    def token_payload(&block)
      @payload = block
    end
  end
end

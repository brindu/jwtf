module JWTF
  class Configuration
    attr_accessor :payload, :algorithm, :secret

    def initialize
      @payload = {}
      @algorithm = 'none'
    end
  end
end

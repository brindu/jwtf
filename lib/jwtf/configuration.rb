module JWTF
  class Configuration
    attr_accessor :payload

    def initialize
      @payload = {}
    end
  end
end

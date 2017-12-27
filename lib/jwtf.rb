require 'jwtf/version'
require 'jwtf/configuration'
require 'jwt'

module JWTF
  class << self
    def config
      @config ||= Configuration.new
    end
  end

  def self.configure
    yield(config)
  end

  def self.generate
    payload = config.payload
    ::JWT.encode(payload, nil, 'none')
  end
end

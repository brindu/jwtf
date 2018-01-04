require 'jwtf/version'
require 'jwtf/configuration'
require 'jwtf/encode'

module JWTF
  def self.configure
    yield(config)
  end

  def self.generate(params = {})
    encoder.call(params)
  end

  class << self
    private

    def config
      @config ||= Configuration.new
    end

    def encoder
      @encoder ||= Encode.new(config)
    end
  end
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jwtf/version'

Gem::Specification.new do |spec|
  spec.name          = 'jwtf'
  spec.version       = JWTF::VERSION
  spec.authors       = ['Alexandre De Pablo']
  spec.email         = ['alexandre.depablo@gmail.com']

  spec.summary       = 'A gem to shape your JSON Web Token with ease.'

  spec.description   = <<DESC
JWTF allows you to configure how your JSON Web Token are generated. With JWT you
are free to choose from a few (a lot !) of options like the signing algorithm
you crave for, the associated secret key and all the reserved claims you wish to
use ! JWTF offers you a way to configure most of it for your application, so you
can concentrate on the access and policy logic you want to put inside your token.
DESC

  spec.homepage      = 'https://github.com/brindu/jwtf'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'jwt', '~> 2.2.0', '>= 2.2.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-reporters', '~> 1.1.19'
  spec.add_development_dependency 'minitest-ci', '~> 3.4.0'
  spec.add_development_dependency 'simplecov'
end

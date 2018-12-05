lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mercedes/version'

Gem::Specification.new do |spec|
  spec.name = 'mercedes'
  spec.version = Mercedes::VERSION
  spec.authors = ['Alfonso Jiménez']
  spec.email = ['me@alfie.cat']

  spec.summary = %q{Ruby client for interacting with Mercedes-Benz Connected Vehicle API}
  spec.description = %q{This client allows to access to relevant information about Mercedes-Benz vehicles and modify its state such as locking/unlocking doors}
  spec.homepage = 'https://github.com/alfonsojimenez/mercedes'
  spec.license = 'MIT'

  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  end
  spec.bindir = 'bin'
  spec.executables  = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'patron', '~> 0.13.1'
  spec.add_dependency 'oj', '~> 3.7.4'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
end

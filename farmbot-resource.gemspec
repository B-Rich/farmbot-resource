# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "farmbot-resource"
  spec.version       = '1.0.0'
  spec.authors       = ["Rick Carlino"]
  spec.email         = ["rick.carlino@gmail.com"]
  spec.description   = "REST API adapter for Farmbot web app."
  spec.summary       = "Ruby Gem to access resources on Farmbot Web App"
  spec.homepage      = "https://github.com/FarmBot/farmbot-resource"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/).select{|f| !f.include?('.gem')}
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_development_dependency "bundler"#,    "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simplecov"

  spec.add_runtime_dependency     'rest-client', "~> 1.8"
end

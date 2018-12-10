
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "strava/route/images/version"

Gem::Specification.new do |spec|
  spec.name          = "strava-route-images"
  spec.version       = Strava::Route::Images::VERSION
  spec.authors       = ["Eustaquio Rangel"]
  spec.email         = ["taq@eustaquiorangel.com"]

  spec.summary       = %q{Extract route images from a Strava URL}
  spec.description   = %q{With this gem we can extract images from the route and altimetry, from a Strava route URL}
  spec.homepage      = 'https://github.com/taq/strava-route-images'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "selenium-webdriver"
  spec.add_development_dependency "mini_magick"
end

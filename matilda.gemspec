lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name = "matilda"
  s.version = "0.0.4"
  s.platform = Gem::Platform::RUBY
  s.authors = ["Callum Stott"]
  s.email = ["callum@seadowg.com"]
  s.summary = "A collection of Functional Programming enhancements for Ruby. Fun and magic."
  s.license = 'MIT'

  s.require_paths = ['lib']
  s.files = `git ls-files`.split("\n")

  s.add_dependency 'matilda-function'
  s.add_dependency 'matilda-maybe'
  s.add_dependency 'matilda-stream'
end

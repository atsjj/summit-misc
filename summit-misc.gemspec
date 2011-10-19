require File.expand_path("../lib/summit/misc/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "summit-misc"
  s.version = Summit::Misc::VERSION
  s.authors = ["Summit Electric Supply"]
  s.email = ["slewis@summit.com"]
  s.summary = "summit-misc-#{s.version}"
  s.description = "A collection of helper and tools classes."
  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end

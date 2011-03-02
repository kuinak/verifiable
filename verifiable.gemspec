# -*- encoding: utf-8 -*-
require File.expand_path("../lib/verifiable/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "verifiable"
  s.version     = Verifiable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Evan Petrie"]
  s.email       = ["ejp@yahoo.com"]
  s.homepage    = "http://rubygems.org/gems/verifiable"
  s.summary     = "Creates verified associations"
  s.description = "Allows associatons to be create that require verification, i.e. email addresses or phone numbers"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "verifiable"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rake", "0.8.7"
  s.add_development_dependency "sqlite3", "1.3.3"
  s.add_development_dependency "activerecord", "2.3.11"
  s.add_development_dependency "ruby-debug"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end

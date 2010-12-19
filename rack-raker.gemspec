require 'rake'

require File.expand_path("../lib/rack/raker/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'rack-raker'
  s.version     = Rack::Raker::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Dale Campbell','Felipe Oliveira']
  s.email       = ['oshuma@gmail.com','felipecvo@gmail.com']
  s.homepage    = 'http://rubygems.org/gems/rack-raker'
  s.summary     = 'Rack Rake middleware/app.'
  s.description = s.summary

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "rack-raker"

  s.add_dependency 'rack', '>= 0.4'

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "test-spec", ">= 0.9.0"

  s.require_paths = %w[lib]

  s.files = FileList[
    'Gemfile',
    'README',
    'Rakefile',
    'config.ru',
    'rack-raker.gemspec',
    'lib/**/*',
    'test/**/*',
  ].to_a

  s.test_files = s.files.select { |path| path =~ /^test\/.*_test.rb/ }

  s.has_rdoc = true
  s.extra_rdoc_files = %w[ README ]
  s.rdoc_options = ['--line-numbers', '--inline-source', '--title', 'Rack::Raker', '--main', 'Rack::Raker']
end

Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name = 'rack-raker'
  s.version = '0.0.1'
  s.date = '2009-11-02'
  s.homepage = 'http://oshuma.github.com/rack-raker'

  s.authors = ['Dale Campbell']
  s.email = 'oshuma@gmail.com'

  s.description = 'Rack Rake middleware/app.'
  s.summary = 'Rack Rake middleware/app.'

  s.add_dependency 'rack', '>= 0.4'
  s.require_paths = %w[lib]

  s.files = %w[
    README
    Rakefile
    config.ru
    rack-raker.gemspec
    lib/rack/raker.rb
    lib/rack/raker/app.rb
    lib/rack/raker/app/views/index.erb
    lib/rack/raker/app/views/layout.erb
    lib/rack/raker/app/views/show.erb
    lib/rack/raker/middleware.rb
    lib/rack/raker/task_manager.rb
    test/Rakefile
    test/test_helper.rb
    test/task_manager_test.rb
  ]

  s.test_files = s.files.select { |path| path =~ /^test\/.*_test.rb/ }

  s.has_rdoc = true
  s.extra_rdoc_files = %w[ README ]
  s.rdoc_options = ['--line-numbers', '--inline-source', '--title', 'Rack::Raker', '--main', 'Rack::Raker']
end

require 'bundler'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

task :default => :test

desc 'Run the tests'
task :test do
  require 'rake/runtest'
  $LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
  Rake.run_tests 'test/**/*_test.rb'
end

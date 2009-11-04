require 'rake/testtask'

task :default => :test

desc 'Run the tests'
task :test do
  require 'rake/runtest'
  $LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
  Rake.run_tests 'test/**/*_test.rb'
end

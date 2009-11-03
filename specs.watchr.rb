# http://gist.github.com/224873
#
# Run me with:
#
#   $ watchr specs.watchr.rb

# --------------------------------------------------
# Convenience Methods
# --------------------------------------------------
def all_test_files
  Dir['test/**/*_test.rb'] - ['test/test_helper.rb']
end

def run(cmd)
  puts(cmd)
  system(cmd)
end

def run_all_tests
  cmd = "ruby -rubygems -Ilib -e'%w( #{all_test_files.join(' ')} ).each {|file| require file }'"
  run(cmd)
end

def run_test(suspect)
  run("ruby -rubygems -Ilib #{suspect}")
end

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch( '^test.*/.*_test\.rb'   )   { |m| run_test(m[0]) }
watch( '^lib/(.*)\.rb'         )   { |m| run_test("test/#{m[1]}_test.rb") }
watch( '^lib/.*/(.*)\.rb'      )   { |m| run_test("test/#{m[1]}_test.rb") }
watch( '^test/test_helper\.rb' )   { run_all_tests }

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
# Ctrl-\
Signal.trap('QUIT') do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end

# Ctrl-C
Signal.trap('INT') { abort("\n") }

require 'rack'
require 'lib/rack/raker'

use Rack::Reloader, 5

# use Rack::Raker, 'Rakefile'
# # To test Raker::Middleware
# require 'rack/lobster'
# run Rack::Lobster.new

run Rack::Raker.new('Rakefile')

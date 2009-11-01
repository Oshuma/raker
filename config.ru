require 'rack'
require 'lib/rack/raker'

use Rack::Reloader, 5

rakefile = ::File.join(::File.dirname(__FILE__), 'Rakefile')

use Rack::Raker, rakefile
# To test Raker::Middleware
require 'rack/lobster'
run Rack::Lobster.new

# run Rack::Raker.new(rakefile)

require 'rack'
require 'lib/rack/raker'

use Rack::Reloader, 0

rakefile = ::File.join(::File.dirname(__FILE__), 'Rakefile')

# Raker::Middleware
use Rack::Raker, rakefile
require 'rack/lobster'
run Rack::Lobster.new

# # Raker::App
# run Rack::Raker.new(rakefile)

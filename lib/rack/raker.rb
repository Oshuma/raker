module Rack
  module Raker

    autoload :App, 'lib/rack/raker/app'
    autoload :Middleware, 'lib/rack/raker/middleware'

    def self.new(*args)
      $stdout.puts "-- DEBUG: Raker.new: #{args.inspect}"
      if args.first.class == String
        # run
        Raker::App.new(*args)
      else
        # use
        Raker::Middleware.new(*args)
      end
    end

  end # Raker
end # Rack

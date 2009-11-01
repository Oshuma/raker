module Rack
  module Raker
    class Middleware

      def initialize(*args)
        $stdout.puts "-- DEBUG: Middleware: #{args.inspect}"
        @args = args
        @app = args.shift
        @rakefile = args.first
      end

      def call(env)
        $stdout.puts "-- DEBUG: Middleware#call: #{env}"
        @status, @headers, @body = @app.call(env)
      end

    end # Middleware
  end # Raker
end # Rack

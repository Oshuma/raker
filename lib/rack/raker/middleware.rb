module Rack
  module Raker
    class Middleware

      def initialize(*args)
        @args = args
        @app = args.shift
        @rakefile = args.first
      end

      def call(env)
        @status, @headers, @body = @app.call(env)
      end

    end # Middleware
  end # Raker
end # Rack
